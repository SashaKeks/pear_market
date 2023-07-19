import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

class ProductBaseRemoteDataSourceImpl implements ProducBaseRemoteDataSource {
  @override
  Future<void> addProduct(Map<String, dynamic> product) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection(AppConstants.productDB);
    productsCollection
        .add(product)
        .catchError((error) => throw AddProductFailure(error.toString()));
  }

  @override
  Future<void> addBuyStatistic(ProductEntity product) async {
    CollectionReference statisticCollection =
        FirebaseFirestore.instance.collection("statistic");
    final result = await statisticCollection
        .doc("${product.buyDateTime.month}_${product.buyDateTime.year}")
        .get();
    if (result.data() == null) {
      final data = {
        "buy": product.buyPrice * product.buyExRate,
        "sell": 0,
        "date": product.buyDateTime,
      };
      statisticCollection
          .doc("${product.buyDateTime.month}_${product.buyDateTime.year}")
          .set(data)
          .catchError((error) => throw ServerFailure(error.toString()));
    } else {
      final data = {
        "buy": (result.data() as Map<String, dynamic>)["buy"] +
            (product.buyPrice * product.buyExRate),
      };
      statisticCollection
          .doc("${product.buyDateTime.month}_${product.buyDateTime.year}")
          .update(data)
          .catchError((error) => throw ServerFailure(error.toString()));
    }
  }

  @override
  Future<void> addSellStatistic(ProductEntity product) async {
    if (product.sellPrice == null) return;
    CollectionReference statisticCollection =
        FirebaseFirestore.instance.collection("statistic");
    final result = await statisticCollection
        .doc("${product.sellDateTime?.month}_${product.sellDateTime?.year}")
        .get();
    if (result.data() == null) {
      final data = {
        "buy": 0,
        "sell": product.sellPrice != null
            ? product.sellPrice! * (product.sellExRate ?? 1)
            : 0,
        "date": product.sellDateTime,
      };
      statisticCollection
          .doc("${product.sellDateTime?.month}_${product.sellDateTime?.year}")
          .set(data)
          .catchError((error) => throw ServerFailure(error.toString()));
    } else {
      final data = {
        "sell": (result.data() as Map<String, dynamic>)["sell"] +
            (product.sellPrice != null
                ? product.sellPrice! * (product.sellExRate ?? 1)
                : 0),
      };
      statisticCollection
          .doc("${product.buyDateTime.month}_${product.buyDateTime.year}")
          .update(data)
          .catchError((error) => throw ServerFailure(error.toString()));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllProducts(ProductType productType,
      [Map<String, dynamic>? params]) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection(AppConstants.productDB);

    final result = await productsCollection
        .where("type", isEqualTo: productType.index)
        .where("storage", isEqualTo: params?["storage"])
        .where("generation", isEqualTo: params?["generation"])
        .where("version", isEqualTo: params?["version"])
        .where("color", isEqualTo: params?["color"])
        .where("condition", isEqualTo: params?["condition"])
        .where("status", isEqualTo: params?["status"])
        .orderBy((params?["status"] != null)
            ? (params?["generation"] != null)
                ? "id"
                : "generation"
            : "status")
        .get()
        .then((snapshot) => snapshot.docs.map((e) {
              final product = e.data() as Map<String, dynamic>;
              product["id"] = e.id;
              return product;
            }).toList())
        .catchError(
          (e) => throw ServerFailure(e.toString()),
        );

    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getStatistic() async {
    CollectionReference statisticCollection =
        FirebaseFirestore.instance.collection("statistic");
    final result = await statisticCollection
        .get()
        .then((snapshot) => snapshot.docs.map((e) {
              final product = e.data() as Map<String, dynamic>;
              return product;
            }).toList())
        .catchError(
          (e) => throw ServerFailure(e.toString()),
        );
    return result;
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> updatedProduct) async {
    final docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(updatedProduct["id"]);
    docRef
        .update(updatedProduct)
        .catchError((e) => throw UpdateProductFailure(e.toString()));
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(productId);
    docRef.delete().catchError((e) => throw DeleteProductFailure(e.toString()));
  }

  @override
  Future<Map<String, dynamic>> getDetail(String productId) async {
    final docRef = FirebaseFirestore.instance
        .collection(AppConstants.productDB)
        .doc(productId);

    return docRef.get().then((value) {
      final product = value.data() as Map<String, dynamic>;
      product["id"] = value.id;
      return product;
    }).catchError((e) => throw ServerFailure(e.toString()));
  }
}
