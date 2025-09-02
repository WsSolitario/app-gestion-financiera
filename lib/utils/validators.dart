class Validators {
  static String? required(String? v) =>
      (v == null || v.trim().isEmpty) ? "Requerido" : null;
}
