import '../entities/iphone_product_entity.dart';
import '../repository/product_base_repository.dart';

class AddProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  AddProductUseCase(this._productBaseRepository);

  Future<void> execute(IphoneProductEntity product) async {
    await _productBaseRepository.addProduct(product);
  }
}
