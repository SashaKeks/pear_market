import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repository/product_base_repository.dart';

class GetDetailUseCase {
  final ProductBaseRepository _productBaseRepository;

  GetDetailUseCase(this._productBaseRepository);

  Future<Either<Failure, Product>> execute(int productId) async {
    return await _productBaseRepository.getDetail(productId);
  }
}
