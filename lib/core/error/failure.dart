abstract class Failure {
  String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class ReadJsonFailure extends Failure {
  ReadJsonFailure(super.errorMessage);
}
