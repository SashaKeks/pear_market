import 'package:get_it/get_it.dart';
import 'package:pear_market/core/service/user_access_service.dart';
import 'package:pear_market/features/admin/data/datasource/users_datasource.dart';
import 'package:pear_market/features/admin/data/repository/users_repository_impl.dart';
import 'package:pear_market/features/admin/domain/repository/users_repository.dart';
import 'package:pear_market/features/admin/domain/usecase/create_user_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/delete_user_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/get_all_users_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/get_user_by_id_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/update_user_usecase.dart';
import 'package:pear_market/features/auth/data/datasource/local/auth_local_datasource.dart';
import 'package:pear_market/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:pear_market/features/auth/data/repository/auth_ropository_impl.dart';
import 'package:pear_market/features/auth/data/repository/auth_secure_storage_repository_impl.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';
import 'package:pear_market/features/auth/domain/repository/auth_secure_storage_repository.dart';
import 'package:pear_market/features/auth/domain/usecase/add_auth_cred_to_secure_storage.dart';
import 'package:pear_market/features/auth/domain/usecase/get_auth_cred_from_secure_storage_use_case.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:pear_market/features/main_app/data/datasource/theme_datasource.dart';
import 'package:pear_market/features/main_app/data/repository/theme_repository_impl.dart';
import 'package:pear_market/features/main_app/data/datasource/theme_datasource_impl.dart';
import 'package:pear_market/features/main_app/domain/repository/theme_repository.dart';
import 'package:pear_market/features/main_app/domain/usecase/get_theme_mode_use_case.dart';
import 'package:pear_market/features/main_app/domain/usecase/set_theme_mode_use_case.dart';
import 'package:pear_market/features/menu/data/repository/generation_repository_impl.dart';
import 'package:pear_market/features/menu/data/datasource/generation_datasource.dart';
import 'package:pear_market/features/menu/domain/repository/generation_repository.dart';
import 'package:pear_market/features/menu/domain/usecase/get_generations_usecase.dart';
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
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    //SERVICE
    getIt.registerLazySingleton(
      () => UserAccessService(),
    );

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
    getIt.registerLazySingleton(
      () => AddAuthCredToSecureStorage(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetAuthCredFromSecureStorage(getIt()),
    );
    //users usecase
    getIt.registerLazySingleton(
      () => GetAllUsersUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => CreateUserUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => DeleteUserUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => UpdateUserUsecase(getIt()),
    );
    getIt.registerLazySingleton(
      () => GetUserByIdUsecase(getIt()),
    );

    ///theme
    getIt.registerLazySingleton(
      () => GetThemeModeUseCase(getIt()),
    );
    getIt.registerLazySingleton(
      () => SetThemeModeUseCase(getIt()),
    );

    ///generation
    getIt.registerLazySingleton(
      () => GetGenerationsUseCase(getIt()),
    );

    ///repositories
    //auth
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<AuthSecureStorageRepository>(
      () => AuthSecureStorageRepositoryImpl(getIt()),
    );

    //product
    getIt.registerLazySingleton<ProductBaseRepositoryImpl>(
      () => ProductBaseRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<ProductParametersRepository>(
      () => ProductParametersRepositoryImpl(getIt()),
    );

    ///theme
    getIt.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(getIt()),
    );

    ///generation
    getIt.registerLazySingleton<GenerationRepository>(
      () => GenerationRepositoryImpl(getIt()),
    );

    /// users
    getIt.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImpl(getIt()),
    );
    //datasources
    getIt.registerLazySingleton<ProducBaseRemoteDataSource>(
      () => ProductBaseRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<RemoteProductCreateSource>(
      () => RemoteProductCreateSource(),
    );

    //theme
    getIt.registerLazySingleton<ThemeDataSource>(
      () => ThemeDataSourceImpl(),
    );

    ///generation
    getIt.registerLazySingleton<GenerationDataSource>(
      () => GenerationDataSource(),
    );

    //users
    getIt.registerLazySingleton<UsersDataSource>(
      () => UsersDataSource(),
    );

    //auth
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt()),
    );
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(),
    );
  }
}
