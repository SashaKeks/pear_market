import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/add_product_page.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/provider/add_product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/menu/menu_page.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/product_detail.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/provider/product_detail_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../features/products/presentation/pages/products/products_page.dart';

final getIt = GetIt.instance;

class AppNavigationNames {
  static const String homePage = '/';
  static const String categoryMenu = '/category_menu';
  static const String productList = '/product_list';
  static const String productDetail = '/product_list/product_detail';
  static const String addProduct = '/add_product';
}

class AppNavigation {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    AppNavigationNames.homePage: (context) => const MenuPage(),
    AppNavigationNames.addProduct: (context) => ChangeNotifierProvider(
          create: (context) => AddProductViewModel(
            context: context,
            addIphoneUseCase: getIt(),
            getProductColorParameterUsecase: getIt(),
            getProductGenerationParameterUsecase: getIt(),
            getProductStorageParameterUsecase: getIt(),
            getProductVersionParameterUsecase: getIt(),
          ),
          lazy: false,
          child: AddProductPage(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigationNames.productList:
        final ProductType productType = settings.arguments as ProductType;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductViewModel(
                getAllIphonesUseCase: getIt(),
                context: context,
                productType: productType),
            child: const ProductsPage(),
          ),
        );
      case AppNavigationNames.productDetail:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductDetailViewModel(
                productType: arguments["type"], productId: arguments["id"]),
            lazy: false,
            child: ProductDetailPage(),
          ),
        );
    }
    return null;
  }
}
