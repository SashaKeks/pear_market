import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class AddIphoneUseCase {
  final ProductBaseRepository _productBaseRepository;

  AddIphoneUseCase(this._productBaseRepository);

  Future<DataState> call(Product product) async {
    return await _productBaseRepository.addProduct(product);
  }
}
