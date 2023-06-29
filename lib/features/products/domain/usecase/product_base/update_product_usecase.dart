import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class UpdateProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  UpdateProductUseCase(this._productBaseRepository);

  Future<void> execute(Product updatedProduct) async {
    await _productBaseRepository.updateProduct(updatedProduct);
  }
}
