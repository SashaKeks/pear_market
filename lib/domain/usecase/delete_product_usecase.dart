import '../repository/product_base_repository.dart';

class DeleteProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  DeleteProductUseCase(this._productBaseRepository);

  Future<void> execute(String productId) async {
    await _productBaseRepository.deleteProduct(productId);
  }
}
