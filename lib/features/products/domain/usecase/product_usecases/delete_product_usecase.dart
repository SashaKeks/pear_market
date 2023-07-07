import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class DeleteProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  DeleteProductUseCase(this._productBaseRepository);

  Future<DataState> call(String productId) async {
    return await _productBaseRepository.deleteProduct(productId);
  }
}
