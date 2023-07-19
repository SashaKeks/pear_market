import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetStatisticUseCase {
  final ProductBaseRepository _productBaseRepository;

  GetStatisticUseCase(this._productBaseRepository);

  Future<Either<Failure, List<StatisticEntity>>> call() async {
    return await _productBaseRepository.getStatistic();
  }
}
