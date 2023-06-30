abstract class Failure {
  String errorMessage;

  Failure(this.errorMessage);
}

class UnknowingFailure extends Failure {
  UnknowingFailure(super.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class AddProductFailure extends Failure {
  AddProductFailure(super.errorMessage);
}

class UpdateProductFailure extends Failure {
  UpdateProductFailure(super.errorMessage);
}

class DeleteProductFailure extends Failure {
  DeleteProductFailure(super.errorMessage);
}

class ReadJsonFailure extends Failure {
  ReadJsonFailure(super.errorMessage);
}
