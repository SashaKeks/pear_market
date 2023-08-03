import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class DeleteProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  DeleteProductUseCase(this._productBaseRepository);

  Future<void> call(String productId) async {
    await _productBaseRepository.deleteProduct(productId);
  }
}
