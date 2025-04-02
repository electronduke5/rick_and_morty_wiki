abstract class ApiState<T extends Object> {
  final T? item;
  final String? message;

  const ApiState({this.item, this.message});
}

class IdleState<T extends Object> extends ApiState<T> {
  const IdleState();
}

class LoadingState<T extends Object> extends ApiState<T> {
  LoadingState();
}

class LoadedState<T extends Object> extends ApiState<T> {
  LoadedState(T? item) : super(item: item);
}

class FailedState<T extends Object> extends ApiState<T> {
  FailedState(String? message) : super(message: message);
}
