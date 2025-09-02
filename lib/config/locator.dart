import "package:get_it/get_it.dart";
import "package:dio/dio.dart";
import "../services/api_client.dart";
import "../services/auth_service.dart";
import "../repositories/auth_repository.dart";
import "../services/group_service.dart";
import "../repositories/group_repository.dart";
import "../services/expense_service.dart";
import "../repositories/expense_repository.dart";
import "../services/invitation_service.dart";
import "../repositories/invitation_repository.dart";
import "../services/payment_service.dart";
import "../repositories/payment_repository.dart";

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final dio = Dio();
  locator.registerLazySingleton<Dio>(() => dio);

  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));

    locator.registerLazySingleton<AuthService>(() => AuthService(locator<ApiClient>()));
    locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<AuthService>()));

    locator.registerLazySingleton<GroupService>(() => GroupService(locator<ApiClient>()));
    locator.registerLazySingleton<GroupRepository>(
        () => GroupRepository(locator<GroupService>()));

    locator.registerLazySingleton<ExpenseService>(() => ExpenseService(locator<ApiClient>()));
    locator.registerLazySingleton<ExpenseRepository>(
        () => ExpenseRepository(locator<ExpenseService>()));

    locator.registerLazySingleton<InvitationService>(() => InvitationService(locator<ApiClient>()));
    locator.registerLazySingleton<InvitationRepository>(
        () => InvitationRepository(locator<InvitationService>()));

    locator.registerLazySingleton<PaymentService>(() => PaymentService(locator<ApiClient>()));
    locator.registerLazySingleton<PaymentRepository>(
        () => PaymentRepository(locator<PaymentService>()));
  }
