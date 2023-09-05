abstract class Failure {
  final String? errorMessage;
  Failure({this.errorMessage});
}

class UnknownFailure extends Failure {
  String? error = "Something went wrong, try again";
  UnknownFailure({this.error}) : super(errorMessage: error);
}

class ServerFailure extends Failure {
  String? error = "Could not load data from the server";
  ServerFailure({this.error}) : super(errorMessage: error);
}

class LocalDatabaseFailure extends Failure {
  String? error = "Could not connect to the database";
  LocalDatabaseFailure({this.error}) : super(errorMessage: error);
}

class AddProductFailure extends Failure {
  String? error = "Could not add data to server, try again";
  AddProductFailure({this.error}) : super(errorMessage: error);
}

class DeleteProductFailure extends Failure {
  String? error = "Could not delete data from server, try again";
  DeleteProductFailure({this.error}) : super(errorMessage: error);
}

class UpdateProductFailure extends Failure {
  String? error = "Could not update data on server, try again";
  UpdateProductFailure({this.error}) : super(errorMessage: error);
}
