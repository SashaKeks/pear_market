import '../entities/product_entity.dart';
import '../repository/product_base_repository.dart';

class UpdateProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  UpdateProductUseCase(this._productBaseRepository);

  Future<void> execute(Product updatedProduct) async {
    await _productBaseRepository.updateProduct(updatedProduct);
  }
}
