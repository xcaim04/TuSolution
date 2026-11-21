import 'package:intl/intl.dart';

import 'constants.dart';

final _money = NumberFormat.currency(
  locale: 'es_GT',
  symbol: '$currencySymbol ',
  decimalDigits: 2,
);

String money(double value) => _money.format(value);

String formatDate(DateTime value) =>
    DateFormat('d MMM y', 'es_ES').format(value);

String formatDateTime(DateTime value) =>
    DateFormat('d MMM y · HH:mm', 'es_ES').format(value);
