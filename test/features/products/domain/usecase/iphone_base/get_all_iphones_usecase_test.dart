import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_all_products_usecase.dart';

class ProductBaseRepositoryMock<T> extends Mock
    implements ProductBaseRepository {}

void main() {
  ProductBaseRepository productBaseRepository = ProductBaseRepositoryMock();
  GetAllProductsUseCase usecase = GetAllProductsUseCase(productBaseRepository);
  const productType = ProductType.iphone;
  List<ProductEntity> productList = [
    ProductEntity.empty(),
    ProductEntity.empty(),
    ProductEntity.empty(),
  ];
  group("get all products usecase", () {
    test("should get all products success", () async {
      when(() => productBaseRepository.getAllProducts(productType))
          .thenAnswer((invocation) async => right(productList));

      final result = await usecase(productType);

      expect(result, right(productList));
    });
    Failure fail = ServerFailure("");
    test("should get all products failure", () async {
      when(() => productBaseRepository.getAllProducts(productType)).thenAnswer(
        (invocation) async => left(fail),
      );

      final result = await usecase(productType);

      expect(result, left(fail));
    });
  });
}
