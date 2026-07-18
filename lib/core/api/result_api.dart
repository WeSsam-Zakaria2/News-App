sealed class ResultApi<T> {}

class Success<T> extends ResultApi<T> {
  T data;
  Success(this.data);
}

class Failure<T> extends ResultApi<T> {
  String errorMessage;
  Failure(this.errorMessage);
}
