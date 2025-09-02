import "package:get_it/get_it.dart";
import "package:dio/dio.dart";
import "../services/api_client.dart";
import "../services/auth_service.dart";
import "../repositories/auth_repository.dart";

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final dio = Dio();
  locator.registerLazySingleton<Dio>(() => dio);

  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));

  locator.registerLazySingleton<AuthService>(() => AuthService(locator<ApiClient>()));
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<AuthService>()));
}
