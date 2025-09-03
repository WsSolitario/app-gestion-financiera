import "../services/app_service.dart";

class AppModeRepository {
  final AppService _service;
  AppModeRepository(this._service);

  Future<String> getAppMode() => _service.getAppMode();
}
