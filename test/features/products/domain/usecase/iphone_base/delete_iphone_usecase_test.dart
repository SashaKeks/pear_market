import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/delete_iphone_usecase.dart';

class ProductBaseRepositoryMock extends Mock implements ProductBaseRepository {}

void main() {
  ProductBaseRepository productBaseRepository = ProductBaseRepositoryMock();
  DeleteIphoneUseCase usecase = DeleteIphoneUseCase(productBaseRepository);
  const productId = "q3i7degiqgdq3e";
  const productType = ProductType.iphone;
  group("delete iphone usecase", () {
    test("should delete iphone success", () async {
      when(() => productBaseRepository.deleteProduct(productId, productType))
          .thenAnswer(
        (invocation) async => DataSuccess(""),
      );

      final result = await usecase(productId, productType);

      expect(result, isA<DataSuccess>());
    });

    test("should delete iphone failure", () async {
      when(() => productBaseRepository.deleteProduct(productId, productType))
          .thenAnswer(
        (invocation) async => DataFailure(""),
      );

      final result = await usecase(productId, productType);

      expect(result, isA<DataFailure>());
    });
  });
}