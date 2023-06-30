import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class UpdateIphoneUseCase {
  final ProductBaseRepository _productBaseRepository;

  UpdateIphoneUseCase(this._productBaseRepository);

  Future<void> call(Product updatedProduct) async {
    await _productBaseRepository.updateProduct(updatedProduct);
  }
}
