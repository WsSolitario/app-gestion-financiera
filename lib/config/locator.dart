import "package:get_it/get_it.dart";
import "package:dio/dio.dart";
import "../services/api_client.dart";
import "../services/auth_service.dart";
import "../services/group_service.dart";
import "../services/invitation_service.dart";
import "../services/expense_service.dart";
import "../services/payment_service.dart";
import "../services/notification_service.dart";
import "../repositories/auth_repository.dart";
import "../repositories/group_repository.dart";

import "../repositories/expense_repository.dart";

import "../repositories/invitation_repository.dart";
import "../repositories/expense_repository.dart";
import "../repositories/payment_repository.dart";
import "../repositories/notification_repository.dart";


final GetIt locator = GetIt.instance;
