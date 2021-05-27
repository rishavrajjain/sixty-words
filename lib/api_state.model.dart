class ApiState<T> {
  ApiState._();
  factory ApiState.error(T error) = ErrorState<T>;
  factory ApiState.success(T value) = SuccessState<T>;
}

class ErrorState<T> extends ApiState<T> {
  ErrorState(this.error) : super._();
  final T error;
}

class SuccessState<T> extends ApiState<T> {
  SuccessState(this.value) : super._();
  final T value;
}
