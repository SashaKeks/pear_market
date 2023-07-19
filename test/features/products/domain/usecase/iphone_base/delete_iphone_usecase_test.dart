import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/delete_product_usecase.dart';

class ProductBaseRepositoryMock extends Mock implements ProductBaseRepository {}

void main() {
  ProductBaseRepository productBaseRepository = ProductBaseRepositoryMock();
  DeleteProductUseCase usecase = DeleteProductUseCase(productBaseRepository);
  const productId = "q3i7degiqgdq3e";
  // const productType = ProductType.iphone;
  group("delete product usecase", () {
    test("should delete product success", () async {
      when(() => productBaseRepository.deleteProduct(productId)).thenAnswer(
        (invocation) async => DataSuccess(""),
      );

      final result = await usecase(productId);

      expect(result, isA<DataSuccess>());
    });

    test("should delete product failure", () async {
      when(() => productBaseRepository.deleteProduct(productId)).thenAnswer(
        (invocation) async => DataFailure(""),
      );

      final result = await usecase(productId);

      expect(result, isA<DataFailure>());
    });
  });
}
