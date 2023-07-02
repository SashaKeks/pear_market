import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_all_iphones_usecase.dart';

class ProductBaseRepositoryMock<T> extends Mock
    implements ProductBaseRepository<IphoneProductEntity> {}

void main() {
  ProductBaseRepository<IphoneProductEntity> productBaseRepository =
      ProductBaseRepositoryMock();
  GetAllIphonesUseCase usecase = GetAllIphonesUseCase(productBaseRepository);
  const productType = ProductType.iphone;
  List<IphoneProductEntity> iphoneList = [
    IphoneProductEntity.empty(),
    IphoneProductEntity.empty(),
    IphoneProductEntity.empty(),
  ];
  group("get all iphones usecase", () {
    test("should get all iphones success", () async {
      when(() => productBaseRepository.getAllProducts(productType))
          .thenAnswer((invocation) async => right(iphoneList));

      final result = await usecase(productType);

      expect(result, right(iphoneList));
    });
    Failure fail = ServerFailure("");
    test("should get all iphones failure", () async {
      when(() => productBaseRepository.getAllProducts(productType)).thenAnswer(
        (invocation) async => left(fail),
      );

      final result = await usecase(productType);

      expect(result, left(fail));
    });
  });
}
