import 'package:get_it/get_it.dart';
import 'package:pear_market/data/repository/product_base_repository_impl.dart';
import 'package:pear_market/data/source/remote_base_datasource.dart';
import 'package:pear_market/domain/usecase/add_product_usecase.dart';
import 'package:pear_market/domain/usecase/delete_product_usecase.dart';
import 'package:pear_market/domain/usecase/get_all_products_usecase.dart';
import 'package:pear_market/domain/usecase/get_detail_usecase.dart';
import 'package:pear_market/domain/usecase/update_product_usecase.dart';

import '../../data/repository/product_add_repository_impl.dart';
import '../../data/source/local_product_create_source.dart';
import '../../domain/repository/product_add_repository.dart';
import '../../domain/repository/product_base_repository.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    //usecases
    getIt.registerLazySingleton(
      () => AddProductUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => DeleteProductUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetAllProductsUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetDetailUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => UpdateProductUseCase(getIt()),
    );

    //repositories
    getIt.registerLazySingleton<ProductBaseRepository>(
      () => ProductBaseRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<ProductAddRepository>(
      () => ProductAddRepositoryImpl(getIt()),
    );

    //datasources
    getIt.registerLazySingleton<RemoteDatasource>(
      () => RemoteBaseDatasource(),
    );
    getIt.registerLazySingleton<LocalProductCreateSource>(
      () => LocalProductCreateSource(),
    );
  }
}
