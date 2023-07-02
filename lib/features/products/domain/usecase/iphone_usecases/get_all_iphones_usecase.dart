import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetAllIphonesUseCase {
  final ProductBaseRepository<IphoneProductEntity> _productBaseRepository;

  GetAllIphonesUseCase(this._productBaseRepository);

  Future<Either<Failure, List<IphoneProductEntity>>> call(
      ProductType productType) async {
    return await _productBaseRepository.getAllProducts(productType);
  }
}
