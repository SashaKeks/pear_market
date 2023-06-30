import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/add_iphone_usecase.dart';

class ProductBaseRepositoryMock extends Mock implements ProductBaseRepository {}

void main() {
  ProductBaseRepository productBaseRepository = ProductBaseRepositoryMock();
  AddIphoneUseCase usecase = AddIphoneUseCase(productBaseRepository);
  final product = IphoneProductEntity.empty();
  group("add product usecase", () {
    test("should add product success", () async {
      when(() => productBaseRepository.addProduct(product)).thenAnswer(
        (invocation) async => DataSuccess("${product.type.name} added"),
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
