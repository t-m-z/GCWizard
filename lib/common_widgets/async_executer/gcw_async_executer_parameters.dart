import 'dart:isolate';

const PROGRESS = 'progress';

// For open-ended jobs without a known total (e.g. GC Wizard Script):
// send IntegerText(PROGRESS_COUNT, count). The executer then shows a running
// indicator with the count instead of a percentage.
const PROGRESS_COUNT = 'progress_count';

class GCWAsyncExecuterParameters {
  SendPort? sendAsyncPort;
  final Object? parameters;

  // Web only: there are no isolates on the web, so the job runs on the UI
  // thread. Long-running jobs can report progress here (same events as on
  // sendAsyncPort) and should briefly yield to the event loop afterwards so
  // that the UI can repaint. Returns false when the user pressed cancel.
  // Always null on other platforms (not sent to isolates).
  bool Function(Object event)? webProgress;

  GCWAsyncExecuterParameters(this.parameters);
}
