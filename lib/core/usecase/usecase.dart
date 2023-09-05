import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call({required Param params});
}
