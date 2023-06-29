abstract class ProducBaseRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllProducts(int productTypeId);
  Future<Map<String, dynamic>> getDetail(int productId);
  Future<void> addProduct(Map<String, dynamic> product);
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(Map<String, dynamic> updatedProduct);
}
