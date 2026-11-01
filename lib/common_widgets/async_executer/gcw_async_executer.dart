import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';

Isolate? _isolate;

const double GCW_ASYNC_EXECUTER_INDICATOR_HEIGHT = 230;
const double GCW_ASYNC_EXECUTER_INDICATOR_WIDTH = 150;

class GCWAsyncExecuter<T> extends StatefulWidget {
  final Future<T> Function(GCWAsyncExecuterParameters) isolatedFunction;
  final Future<GCWAsyncExecuterParameters?> Function() parameter;
  final void Function(T) onReady;
  final bool isOverlay;

  const GCWAsyncExecuter({
    super.key,
    required this.isolatedFunction,
    required this.parameter,
    required this.onReady,
    this.isOverlay = true,
  });

  @override
  _GCWAsyncExecuterState<T> createState() => _GCWAsyncExecuterState<T>();
}

Future<ReceivePort> _makeIsolate(
    void Function(GCWAsyncExecuterParameters) isolatedFunction, GCWAsyncExecuterParameters parameters) async {
  ReceivePort receivePort = ReceivePort();
  parameters.sendAsyncPort = receivePort.sendPort;

  _isolate = await Isolate.spawn(isolatedFunction, parameters);

  return receivePort;
}

class _GCWAsyncExecuterState<T> extends State<GCWAsyncExecuter<T>> {
  T? _result;
  bool isOverlay = true;
  bool _cancel = false;
  ReceivePort? _receivePort;

  _GCWAsyncExecuterState();

  // Created once: build() can run several times (e.g. when the keyboard
  // closes or the dialog animates). A stream created in build() started a new
  // isolate on every rebuild; the old isolates were never killed and kept
  // running, so no progress value ever reached the dialog.
  late final Stream<num> _progressStream;

  @override
  void initState() {
    super.initState();
    isOverlay = widget.isOverlay;
    _progressStream = _progress();
  }

  // Yields a double (0..1) for percentage progress (PROGRESS) or an int for
  // counter progress (PROGRESS_COUNT).
  Stream<num> _progress() async* {
    var parameter = await widget.parameter();
    if (!_cancel && parameter != null) {
      if (kIsWeb) {
        // No isolates on the web: run on the UI thread. Jobs that support
        // it report progress via webProgress and yield in between.
        final events = StreamController<Object>();
        parameter.webProgress = (event) {
          if (!events.isClosed) events.add(event);
          return !_cancel;
        };
        widget.isolatedFunction(parameter).then((result) {
          if (!_cancel) _result = result;
          events.close();
        }, onError: (Object error, StackTrace stackTrace) {
          events.addError(error, stackTrace);
          events.close();
        });
        await for (var event in events.stream) {
          if (event is DoubleText && event.text == PROGRESS) {
            yield event.value;
          } else if (event is IntegerText && event.text == PROGRESS_COUNT) {
            yield event.value;
          }
        }
        return;
      } else {
        _receivePort = await _makeIsolate(widget.isolatedFunction, parameter);
      }
      if (_cancel) {
        _cancelProcess();
        return;
      }

      await for (var event in _receivePort!) {
        if (_cancel) {
          _cancelProcess();
          break;
        }
        if (event is DoubleText && event.text == PROGRESS) {
          yield event.value;
        } else if (event is IntegerText && event.text == PROGRESS_COUNT) {
          yield event.value;
        } else if (event is T) {
          _result = event;
          _receivePort!.close();
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    _cancelProcess(); // Beende alle Ressourcen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _progressStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.isOverlay) {
              Navigator.of(context, rootNavigator: true).pop(); // Pop from dialog on completion (needen on overlay)
              _cancelProcess();
            }
            if (_result is T) {
              widget.onReady(_result as T);
            }
          }
          return Column(children: <Widget>[
            (snapshot.hasData && snapshot.data is double)
                ? Expanded(
                    child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                      value: snapshot.data as double,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                      strokeWidth: 20,
                    ),
                    Positioned(
                      child: Center(
                        child: Text(
                          ((snapshot.data as double) * 100).toStringAsFixed(0).toString() + '%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ]))
                : (snapshot.hasData && snapshot.data is int)
                    ? Expanded(
                        child: Stack(fit: StackFit.expand, children: [
                        const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                          strokeWidth: 20,
                        ),
                        Positioned(
                          child: Center(
                            child: Text(
                              _formatCount(snapshot.data as int),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      ]))
                    : const Expanded(
                        child: Stack(fit: StackFit.expand, children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                          strokeWidth: 20,
                        )
                      ])),
            const SizedBox(height: 10),
            GCWButton(
              text: i18n(context, 'common_cancel'),
              onPressed: () {
                _cancelProcess();
                _cancel = true;
              },
            )
          ]);
        });
  }

  // 1234567 -> '1 234 567' (narrow no-break spaces, language-neutral)
  String _formatCount(int count) {
    final digits = count.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('\u202F');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  void _cancelProcess() {
    if (_isolate != null) {
      _isolate!.kill(priority: Isolate.immediate);
      _isolate = null;
    }
    if (_receivePort != null) {
      _receivePort!.close();
      _receivePort = null;
    }
  }
}
