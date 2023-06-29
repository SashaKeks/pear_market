import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetDetailUseCase {
  final ProductBaseRepository<Product> _productBaseRepository;

  GetDetailUseCase(this._productBaseRepository);

  Future<Either<Failure, Product>> execute(int productId) async {
    return await _productBaseRepository.getDetail(productId);
  }
}
