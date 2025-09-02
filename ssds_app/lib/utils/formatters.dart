import "package:intl/intl.dart";

class Formatters {
  static final _currency = NumberFormat.simpleCurrency(locale: "es_MX");
  static String money(num value) => _currency.format(value);
}
