import 'package:pear_market/core/common/data_state.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';

class AddIphoneUseCase {
  final ProductBaseRepository<IphoneProductEntity> _productBaseRepository;

  AddIphoneUseCase(this._productBaseRepository);

  Future<DataState> call(IphoneProductEntity product) async {
    return await _productBaseRepository.addProduct(product);
  }
}
