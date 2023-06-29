import 'package:get_it/get_it.dart';
import 'package:pear_market/features/products/data/data_source/local/local_product_create_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source_impl.dart';
import 'package:pear_market/features/products/data/repository/iphone_base_repository.dart';
import 'package:pear_market/features/products/data/repository/product_parameters_repository_impl.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_base_repository.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/add_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/delete_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/get_all_products_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/get_detail_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/update_product_usecase.dart';

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
    getIt.registerLazySingleton<ProductBaseRepository<Product>>(
      () => IphoneBaseRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<ProductParametersRepository>(
      () => ProductParametersRepositoryImpl(getIt()),
    );

    //datasources
    getIt.registerLazySingleton<ProducBaseRemoteDataSource>(
      () => ProductBaseRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<LocalProductCreateSource>(
      () => LocalProductCreateSource(),
    );
  }
}
