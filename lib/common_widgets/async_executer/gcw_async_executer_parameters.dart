import 'dart:isolate';

const PROGRESS = 'progress';

// For open-ended jobs without a known total (e.g. GC Wizard Script):
// send IntegerText(PROGRESS_COUNT, count). The executer then shows a running
// indicator with the count instead of a percentage.
const PROGRESS_COUNT = 'progress_count';

class GCWAsyncExecuterParameters {
  SendPort? sendAsyncPort;
  final Object? parameters;

  GCWAsyncExecuterParameters(this.parameters);
}
