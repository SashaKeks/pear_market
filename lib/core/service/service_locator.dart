import 'package:get_it/get_it.dart';
import 'package:pear_market/features/auth/data/repository/auth_ropository_impl.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:pear_market/features/products/data/data_source/local/local_product_create_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source_impl.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_create_source.dart';
import 'package:pear_market/features/products/data/repository/product_base_repository.dart';
import 'package:pear_market/features/products/data/repository/product_parameters_repository_impl.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_proc_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_ram_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_video_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/add_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/delete_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_all_products_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_product_detail_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_statistic_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    //USECASE

    ///product
    getIt.registerLazySingleton(
      () => AddProductUseCase(getIt<ProductBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => DeleteProductUseCase(getIt<ProductBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => GetAllProductsUseCase(getIt<ProductBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => GetProductDetailUseCase(getIt<ProductBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => UpdateProductUseCase(getIt<ProductBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => GetStatisticUseCase(getIt<ProductBaseRepositoryImpl>()),
    );

    ///parameters
    getIt.registerLazySingleton(
      () => GetProductColorParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductProcParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductVideoParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductRamParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductStorageParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductVersionParameterUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetProductGenerationParameterUsecase(getIt()),
    );

    //auth usecase
    getIt.registerLazySingleton(
      () => SignInUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => SignOutUseCase(getIt()),
    );

    ///repositories
    //auth
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(),
    );
    //product
    getIt.registerLazySingleton<ProductBaseRepositoryImpl>(
      () => ProductBaseRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<ProductParametersRepository>(
      () => ProductParametersRepositoryImpl(getIt()),
    );

    //datasources
    getIt.registerLazySingleton<ProducBaseRemoteDataSource>(
      () => ProductBaseRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<RemoteProductCreateSource>(
      () => RemoteProductCreateSource(),
    );
    // getIt.registerLazySingleton<LocalProductCreateSource>(
    //   () => LocalProductCreateSource(),
    // );
  }
}
