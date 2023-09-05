import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/usecase/usecase.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/domain/entities/filter_product_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class GetAllProductsUseCase
    implements UseCase<List<ProductEntity>, GetAllProductsParams> {
  final ProductBaseRepository _productBaseRepository;

  GetAllProductsUseCase(this._productBaseRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      {required GetAllProductsParams params}) async {
    return await _productBaseRepository.getAllProducts(
        params.productType, params.filter);
  }
}

class GetAllProductsParams {
  final ProductTypeEnum productType;
  final FilterProductEntity? filter;

  GetAllProductsParams({
    required this.productType,
    this.filter,
  });
}
