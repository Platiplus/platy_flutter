import 'package:intl/intl.dart';

final RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    caseSensitive: false,
    multiLine: false
);

final RegExp numberRegex = new RegExp(
  r"^(-?\d+\.\d+)$|^(-?\d+)$",
  caseSensitive: false,
  multiLine: false
);

final RegExp brNumberRegex = new RegExp(
  r"^(-?\d+\,\d+)$|^(-?\d+)$",
  caseSensitive: false,
  multiLine: false
);

final RegExp brDateRegex = new RegExp(
  r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
  caseSensitive: false,
  multiLine: false
);

final requestHeaders = {
  'content-type': 'application/json'
};

final dateFormatter = DateFormat("dd/MM/yyyy");

final currencyFormatter = new NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
final currencyFormatterNoSymbol = new NumberFormat.currency(locale: "pt_BR", symbol: "");