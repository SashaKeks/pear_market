import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:pear_market/features/auth/presentation/providers/auth_view_model.dart';
import 'package:pear_market/features/auth/presentation/providers/reg_view_model.dart';
import 'package:pear_market/features/auth/presentation/pages/reg/reg_page.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';
import 'package:pear_market/features/menu/presentation/pages/home_page.dart';
import 'package:pear_market/features/menu/presentation/pages/sub_menu_screen.dart';
import 'package:pear_market/features/menu/presentation/provider/sub_menu_view_model.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/presentation/pages/add_product_other.dart/add_product_other_page.dart';
import 'package:pear_market/features/products/presentation/pages/add_product_other.dart/provider/add_product_other_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/form_for_product_page.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/provider/form_for_product_view_model.dart';
import 'package:pear_market/features/menu/presentation/provider/menu_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/product_detail.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/provider/product_detail_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/sell_product/provider/sell_product_view_model.dart';
import 'package:pear_market/features/products/presentation/pages/sell_product/sell_product_page.dart';
import 'package:provider/provider.dart';

import '../../../features/products/presentation/pages/products/products_page.dart';

final getIt = GetIt.instance;

class AppNavigation {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    AppNavigationNames.authPage: (context) => ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            context: context,
            signInUseCase: getIt(),
            userAccessService: getIt(),
            getAuthCredFromSecureStorage: getIt(),
            addAuthCredToSecureStorage: getIt(),
          ),
          lazy: false,
          child: const AuthPage(),
        ),
    AppNavigationNames.homePage: (context) => ChangeNotifierProvider(
          create: (context) => MenuViewModel(
            context,
            getIt(),
            getIt(),
          ),
          child: HomePage(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigationNames.subMenu:
        final subMenuType = settings.arguments as ProductTypeEnum;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => SubMenuViewModel(
                    getIt(),
                    context,
                    subMenuType: subMenuType,
                  ),
                  child: const SubMenuScreen(),
                ));
      case AppNavigationNames.regPage:
        final user = settings.arguments as CustomUserEntity?;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => RegViewModel(
                    user,
                    getIt(),
                    getIt(),
                    context: context,
                  ),
                  child: const RegPage(),
                ));
      case AppNavigationNames.productList:
        final GenerationEntity generation =
            settings.arguments as GenerationEntity;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductViewModel(
              getIt(),
              getAllProductsUseCase: getIt(),
              storageParameterUsecase: getIt(),
              generationParameterUsecase: getIt(),
              colorParameterUsecase: getIt(),
              versionParameterUsecase: getIt(),
              context: context,
              generation: generation,
              getUserByIdUsecase: getIt(),
            ),
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
        ProductTypeEnum? productType;
        ProductEntity? product;
        if (settings.arguments is ProductTypeEnum) {
          productType = settings.arguments as ProductTypeEnum;
        } else {
          product = settings.arguments == null
              ? null
              : settings.arguments as ProductEntity;
        }
        if ((productType != null &&
                (productType == ProductTypeEnum.accessories ||
                    productType == ProductTypeEnum.other)) ||
            (product != null &&
                (product.type == ProductTypeEnum.accessories ||
                    product.type == ProductTypeEnum.other))) {
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
                userAccessService: getIt(),
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
