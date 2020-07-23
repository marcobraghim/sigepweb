class SigepwebRuntimeError implements Error {
  final String msg;

  const SigepwebRuntimeError([this.msg]);

  @override
  StackTrace get stackTrace => stackTrace;

  @override
  String toString() =>
      msg ??
      'Correios API is probably out of service. It shouldn\'t, but happen all the time...';
}
