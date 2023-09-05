import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums/price_status_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/features/products/data/models/price_model.dart';
import 'package:pear_market/features/products/data/models/product_configuration_model.dart';
import 'package:pear_market/features/products/data/models/product_info_model.dart';
import 'package:pear_market/features/products/data/models/product_model.dart';
import 'package:pear_market/features/products/domain/entities/filter_product_entity.dart';

class ProductBaseRemoteDataSourceImpl implements ProducBaseRemoteDataSource {
  @override
  Future<void> addProduct(ProductModel product) async {
    CollectionReference? productsCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${AppConstants.productTable}");

    final productDocRef = await productsCollection
        .add(product.toJson())
        .catchError((error) => throw ServerAddProductException());
    await updateProduct(product.copyModelWith(id: productDocRef.id));
    await _addPriceForProduct(
      PriceModel.fromEntity(product.buyPrice),
      productDocRef.id,
    );
    await _addPriceForProduct(
      PriceModel.fromEntity(product.sellPrice),
      productDocRef.id,
    );

    await _addConfigurationForProduct(
      ProductConfigurationModel.fromEntity(product.productConfiguration),
      productDocRef.id,
    );

    await _addInfoForProduct(
      ProductInfoModel.fromEntity(product.productInfo),
      productDocRef.id,
    );
  }

  Future<void> _addInfoForProduct(
    ProductInfoModel infoModel,
    String productId,
  ) async {
    CollectionReference? infoCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productInfoTable}");

    await infoCollection
        .doc(productId)
        .set(infoModel.toJson())
        .catchError((e) => throw ServerAddProductException());
  }

  Future<void> _addPriceForProduct(
    PriceModel priceModel,
    String productId,
  ) async {
    CollectionReference? priceCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${priceModel.status.name}");

    await priceCollection
        .doc(productId)
        .set(priceModel.toJson())
        .catchError((e) => throw ServerAddProductException());
  }

  Future<void> _addConfigurationForProduct(
    ProductConfigurationModel configurationModel,
    String productId,
  ) async {
    CollectionReference? configCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productConfigurationTable}");

    await configCollection
        .doc(productId)
        .set(configurationModel.toJson())
        .catchError((e) => throw ServerAddProductException());
  }

  @override
  Future<List<ProductModel>> getAllProducts(ProductTypeEnum productType,
      [FilterProductEntity? params]) async {
    CollectionReference? productsCollection =
        FirebaseFirestore.instance.collection(AppConstants.productDB);

    final result = await productsCollection
        .where("type", isEqualTo: productType.index)
        .where("storage", isEqualTo: params?.storage)
        .where("generation", isEqualTo: params?.generation)
        .where("color", isEqualTo: params?.color)
        .where("condition", isEqualTo: params?.condition)
        .where("status", isEqualTo: params?.status)
        .orderBy("id")
        .get()
        .then((snapshot) {
      return snapshot.docs.map((value) {
        Map<String, dynamic> product = value.data() as Map<String, dynamic>;

        _getConfigurationForProduct(product["id"])
            .then((value) => product["productConfiguration"] = value);

        _getPriceForProduct(PriceStatusEnum.sell, product["id"])
            .then((value) => product["sellPrice"] = value);

        _getInfoForProduct(product["id"])
            .then((value) => product["productInfo"] = value);

        _getPriceForProduct(PriceStatusEnum.buy, product["id"])
            .then((value) => product["buyPrice"] = value);

        return ProductModel.fromJson(product);
      }).toList();
    }).catchError(
      (e) => throw ServerGetProductException(),
    );
    return result;
  }

  @override
  Future<void> updateProduct(ProductModel updatedProduct) async {
    CollectionReference? productsCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${AppConstants.productTable}");

    if (updatedProduct.id != null || updatedProduct.id == "") {
      await productsCollection
          .doc(updatedProduct.id)
          .update(updatedProduct.toJson())
          .catchError((error) => throw ServerUpdateProductException());

      await _updatePriceForProduct(
        PriceModel.fromEntity(updatedProduct.buyPrice),
        updatedProduct.id!,
      );
      await _updatePriceForProduct(
        PriceModel.fromEntity(updatedProduct.sellPrice),
        updatedProduct.id!,
      );

      await _updateConfigurationForProduct(
        ProductConfigurationModel.fromEntity(
            updatedProduct.productConfiguration),
        updatedProduct.id!,
      );

      await _updateInfoForProduct(
        ProductInfoModel.fromEntity(updatedProduct.productInfo),
        updatedProduct.id!,
      );
    } else {
      throw ServerUpdateProductException();
    }
  }

  Future<void> _updateInfoForProduct(
    ProductInfoModel infoModel,
    String productId,
  ) async {
    CollectionReference? infoCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productInfoTable}");

    await infoCollection
        .doc(productId)
        .update(infoModel.toJson())
        .catchError((e) => throw ServerUpdateProductException());
  }

  Future<void> _updatePriceForProduct(
    PriceModel priceModel,
    String productId,
  ) async {
    CollectionReference? priceCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${priceModel.status.name}");

    await priceCollection
        .doc(productId)
        .update(priceModel.toJson())
        .catchError((e) => throw ServerUpdateProductException());
  }

  Future<void> _updateConfigurationForProduct(
    ProductConfigurationModel configurationModel,
    String productId,
  ) async {
    CollectionReference? configCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productConfigurationTable}");

    await configCollection
        .doc(productId)
        .update(configurationModel.toJson())
        .catchError((e) => throw ServerUpdateProductException());
  }

  @override
  Future<void> deleteProduct(String productId) async {
    CollectionReference? productsCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${AppConstants.productTable}");
    CollectionReference? infoCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productInfoTable}");
    CollectionReference? configCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productConfigurationTable}");

    productsCollection
        .doc(productId)
        .delete()
        .catchError((e) => throw ServerDeleteProductException());

    infoCollection
        .doc(productId)
        .delete()
        .catchError((e) => throw ServerDeleteProductException());

    configCollection
        .doc(productId)
        .delete()
        .catchError((e) => throw ServerDeleteProductException());
  }

  @override
  Future<ProductModel> getDetail(String productId) async {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${AppConstants.productTable}")
        .doc(productId);

    final result = docRef.get().then((value) async {
      final product = value.data() as Map<String, dynamic>;

      product["productConfiguration"] =
          await _getConfigurationForProduct(productId);
      product["sellPrice"] =
          await _getPriceForProduct(PriceStatusEnum.sell, productId);
      product["productInfo"] = await _getInfoForProduct(productId);
      product["buyPrice"] =
          await _getPriceForProduct(PriceStatusEnum.buy, productId);
      return ProductModel.fromJson(product);
    }).catchError((e) => throw ServerGetProductException());
    return result;
  }

  Future<Map<String, dynamic>> _getInfoForProduct(String productId) async {
    CollectionReference? infoCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productInfoTable}");

    return await infoCollection.doc(productId).get().then((value) async {
      Map<String, dynamic> json = value.data() as Map<String, dynamic>;
      json["owner"] = await _getUserForProduct(json["owner"]);
      json["whoCreate"] = await _getUserForProduct(json["whoCreate"]);
      return json;
    }).catchError((e) => throw ServerGetProductException());
  }

  Future<Map<String, dynamic>> _getPriceForProduct(
      PriceStatusEnum status, String productId) async {
    CollectionReference? priceCollection = FirebaseFirestore.instance
        .collection("${AppConstants.productDB}/${status.name}");

    return await priceCollection
        .doc(productId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>)
        .catchError((e) => throw ServerGetProductException());
  }

  Future<Map<String, dynamic>> _getConfigurationForProduct(
      String productId) async {
    CollectionReference? configCollection = FirebaseFirestore.instance.collection(
        "${AppConstants.productDB}/${AppConstants.productConfigurationTable}");

    return await configCollection
        .doc(productId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>)
        .catchError((e) => throw ServerGetProductException());
  }

  Future<Map<String, dynamic>> _getUserForProduct(String customUserId) {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.usersDB)
        .doc(customUserId);
    return docRef
        .get()
        .then((value) => value.data() as Map<String, dynamic>)
        .catchError((e) => throw ServerFailure(error: e.toString()));
  }
}
