class DataState {
  final String? success;
  final String? failure;

  DataState({this.success, this.failure});
}

class DataSuccess extends DataState {
  DataSuccess(String? success) : super(success: success);
}

class DataFailure extends DataState {
  DataFailure(String? failure) : super(failure: failure);
}
