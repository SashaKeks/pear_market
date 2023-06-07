import 'package:dartz/dartz.dart';
import 'package:pear_market/domain/entities/product_entity.dart';
import 'package:pear_market/domain/repository/product_base_repository.dart';

import '../../core/error/failure.dart';

class GetAllProductsUseCase {
  final ProductBaseRepository _productBaseRepository;

  GetAllProductsUseCase(this._productBaseRepository);

  Future<Either<Failure, List<Product>>> execute(int productTypeId) async {
    return await _productBaseRepository.getAllProducts(productTypeId);
  }
}
