import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class DeleteIphoneUseCase {
  final ProductBaseRepository _productBaseRepository;

  DeleteIphoneUseCase(this._productBaseRepository);

  Future<DataState> call(String productId, ProductType productType) async {
    return await _productBaseRepository.deleteProduct(productId, productType);
  }
}
