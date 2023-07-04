import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/add_product_usecase.dart';

class ProductBaseRepositoryMock extends Mock
    implements ProductBaseRepository<ProductEntity> {}

void main() {
  ProductBaseRepository<ProductEntity> productBaseRepository =
      ProductBaseRepositoryMock();
  AddProductUseCase usecase = AddProductUseCase(productBaseRepository);
  final product = ProductEntity.empty();
  group("add product usecase", () {
    test("should add product success", () async {
      when(() => productBaseRepository.addProduct(product)).thenAnswer(
        (invocation) async => DataSuccess(""),
      );

      final result = await usecase(product);

      expect(result, isA<DataSuccess>());
    });

    test("should add product failure", () async {
      when(() => productBaseRepository.addProduct(product)).thenAnswer(
        (invocation) async => DataFailure(""),
      );

      final result = await usecase(product);

      expect(result, isA<DataFailure>());
    });
  });
}
