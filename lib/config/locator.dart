import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

import "../repositories/auth_repository.dart";
import "../repositories/expense_repository.dart";
import "../repositories/group_repository.dart";
import "../repositories/invitation_repository.dart";
import "../repositories/notification_repository.dart";
import "../repositories/recurring_payment_repository.dart";
import "../repositories/reports_repository.dart";
import "../repositories/app_mode_repository.dart";

// 👇 Alias para evitar ambigüedad:
import "../repositories/payment_repository.dart" as pay_repo;
import "../services/payment_service.dart" as pay_svc;

import "../services/api_client.dart";
import "../services/app_service.dart";
import "../services/auth_service.dart";
import "../services/expense_service.dart";
import "../services/group_service.dart";
import "../services/invitation_service.dart";
import "../services/notification_service.dart";
import "../services/recurring_payment_service.dart";
import "../services/reports_service.dart";

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));

  // Services
  locator.registerLazySingleton<AuthService>(
    () => AuthService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<AppService>(
    () => AppService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<GroupService>(
    () => GroupService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<ExpenseService>(
    () => ExpenseService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<InvitationService>(
    () => InvitationService(locator<ApiClient>()),
  );

  // 👇 Usa el prefijo del alias
  locator.registerLazySingleton<pay_svc.PaymentService>(
    () => pay_svc.PaymentService(locator<ApiClient>()),
  );

  locator.registerLazySingleton<NotificationService>(
    () => NotificationService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<RecurringPaymentService>(
    () => RecurringPaymentService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<ReportsService>(
    () => ReportsService(locator<ApiClient>()),
  );

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(locator<AuthService>()),
  );
  locator.registerLazySingleton<GroupRepository>(
    () => GroupRepository(locator<GroupService>()),
  );
  locator.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepository(locator<ExpenseService>()),
  );
  locator.registerLazySingleton<InvitationRepository>(
    () => InvitationRepository(locator<InvitationService>()),
  );

  // 👇 Usa el prefijo del alias y pasa el servicio aliased
  locator.registerLazySingleton<pay_repo.PaymentRepository>(
    () => pay_repo.PaymentRepository(
      locator<pay_svc.PaymentService>() as pay_repo.PaymentService,
    ),
  );

  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(locator<NotificationService>()),
  );
  locator.registerLazySingleton<RecurringPaymentRepository>(
    () => RecurringPaymentRepository(locator<RecurringPaymentService>()),
  );
  locator.registerLazySingleton<ReportsRepository>(
    () => ReportsRepository(locator<ReportsService>()),
  );
  locator.registerLazySingleton<AppModeRepository>(
    () => AppModeRepository(locator<AppService>()),
  );
}
