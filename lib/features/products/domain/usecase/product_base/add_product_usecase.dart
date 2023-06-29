import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class AddProductUseCase {
  final ProductBaseRepository _productBaseRepository;

  AddProductUseCase(this._productBaseRepository);

  Future<void> execute(Product product) async {
    await _productBaseRepository.addProduct(product);
  }
}
