import 'package:get_it/get_it.dart';
import 'package:pear_market/features/products/data/data_source/local/local_product_create_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source.dart';
import 'package:pear_market/features/products/data/data_source/remote/product_base_remote_data_source_impl.dart';
import 'package:pear_market/features/products/data/repository/iphone_base_repository.dart';
import 'package:pear_market/features/products/data/repository/product_parameters_repository_impl.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/add_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/delete_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_all_iphones_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_iphone_detail_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/update_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    //USECASE
    //iphone_usecase
    getIt.registerLazySingleton(
      () => AddIphoneUseCase(getIt<IphoneBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => DeleteIphoneUseCase(getIt<IphoneBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => GetAllIphonesUseCase(getIt<IphoneBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => GetIphoneDetailUseCase(getIt<IphoneBaseRepositoryImpl>()),
    );
    getIt.registerLazySingleton(
      () => UpdateIphoneUseCase(getIt<IphoneBaseRepositoryImpl>()),
    );
    //parameters
    getIt.registerLazySingleton(
      () => GetProductColorParameterUsecase(getIt()),
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

    //repositories
    getIt.registerLazySingleton<IphoneBaseRepositoryImpl>(
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
