import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/provider/auth_view_model.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/presentation/pages/add_product_other.dart/add_product_other_page.dart';
import 'package:pear_market/features/products/presentation/pages/add_product_other.dart/provider/add_product_other_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/form_for_product_page.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/provider/form_for_product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/menu/menu_page.dart';
import 'package:pear_market/features/products/presentation/pages/menu/provider/menu_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/product_detail.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/provider/product_detail_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/sell_product/provider/sell_product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/sell_product/sell_product_page.dart';
import 'package:provider/provider.dart';

import '../../features/products/presentation/pages/products/products_page.dart';

final getIt = GetIt.instance;

class AppNavigationNames {
  static const String authPage = '/';
  static const String homePage = '/home';
  static const String productList = '/product_list';
  static const String productDetail = '/product_list/product_detail';
  static const String formForProduct = '/form_for_product';
  static const String sellProduct = '/sell_product';
}

class AppNavigation {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    AppNavigationNames.authPage: (context) => ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
          lazy: false,
          child: const AuthPage(),
        ),
    AppNavigationNames.homePage: (context) => ChangeNotifierProvider(
          create: (context) => MenuViewModel(getIt(), context),
          lazy: false,
          child: const MenuPage(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigationNames.productList:
        final ProductType productType = settings.arguments as ProductType;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductViewModel(
                getAllProductsUseCase: getIt(),
                storageParameterUsecase: getIt(),
                generationParameterUsecase: getIt(),
                colorParameterUsecase: getIt(),
                versionParameterUsecase: getIt(),
                context: context,
                productType: productType),
            child: const ProductsPage(),
          ),
        );
      case AppNavigationNames.sellProduct:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SellProductViewModel(
              updateProductUseCase: getIt(),
              context: context,
              product: product,
            ),
            child: const SellProductPage(),
          ),
        );
      case AppNavigationNames.productDetail:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductDetailViewModel(
              productType: arguments["type"],
              productId: arguments["id"],
              context: context,
              getProductDetailUsecase: getIt(),
              deleteProductUseCase: getIt(),
              updateProductUseCase: getIt(),
            ),
            child: const ProductDetailPage(),
          ),
        );
      case AppNavigationNames.formForProduct:
        ProductType? productType;
        ProductEntity? product;
        if (settings.arguments is ProductType) {
          productType = settings.arguments as ProductType;
        } else {
          product = settings.arguments == null
              ? null
              : settings.arguments as ProductEntity;
        }
        if ((productType != null &&
                (productType == ProductType.accessories ||
                    productType == ProductType.other)) ||
            (product != null &&
                (product.type == ProductType.accessories ||
                    product.type == ProductType.other))) {
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => AddProductOtherViewModel(
                context: context,
                productType: productType,
                editProduct: product,
                addProductUseCase: getIt(),
                updateProductUseCase: getIt(),
              ),
              child: const AddProductOtherPage(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => FormForProductViewModel(
                context: context,
                productType: productType,
                editproduct: product,
                addProductUseCase: getIt(),
                updateProductUseCase: getIt(),
                getProductColorUsecase: getIt(),
                getProductGenerationUsecase: getIt(),
                getProductStorageUsecase: getIt(),
                getProductVersionUsecase: getIt(),
                getProductProcUsecase: getIt(),
                getProductRamUsecase: getIt(),
                getProductVideoUsecase: getIt(),
              ),
              child: const FormForProductPage(),
            ),
          );
        }
    }
    return null;
  }
}
