abstract class ApiState<T extends Object> {
  final T? item;
  final String? message;

  const ApiState({this.item, this.message});
}

class IdleStatus<T extends Object> extends ApiState<T> {
  const IdleStatus();
}

class LoadingStatus<T extends Object> extends ApiState<T> {
  LoadingStatus();
}

class LoadedStatus<T extends Object> extends ApiState<T> {
  LoadedStatus(T? item) : super(item: item);
}

class FailedStatus<T extends Object> extends ApiState<T> {
  FailedStatus(String? message) : super(message: message);
}
