import '../../domain/entities/product_entity.dart';

abstract class RemoteDatasource {
  Future<List<Product>> getAllProducts(int productTypeId);
  Future<Product> getDetail(int productId);
  Future<void> addProduct(Product product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Product updatedProduct);
}

class RemoteBaseDatasource implements RemoteDatasource {}
