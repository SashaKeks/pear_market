import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/add_product_page.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/provider/add_product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/menu/menu_page.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../features/products/presentation/pages/products/products_page.dart';

final getIt = GetIt.instance;

class AppNavigationNames {
  static const String homePage = '/';
  static const String categoryMenu = '/category_menu';
  static const String iphoneList = '/iphone_list';
  static const String addProduct = '/add_product';
}

class AppNavigation {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    AppNavigationNames.homePage: (context) => const MenuPage(),
    AppNavigationNames.iphoneList: (context) => ChangeNotifierProvider(
          create: (context) => ProductViewModel(getIt(), context),
          child: const ProductsPage(),
        ),
    AppNavigationNames.addProduct: (context) => ChangeNotifierProvider(
          create: (context) => AddProductViewModel(context, getIt(), getIt()),
          lazy: false,
          child: AddProductPage(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      
    }
    return null;
  }
}
