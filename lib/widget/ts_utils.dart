
import 'package:intl/intl.dart';

///
/// --------------------------------------------
/// There are many amazing [Function]s in this class.
/// Especialy in [Function]ality.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
class TsUtils {
  static const String CURRENCY = 'MMK';
  static const String currency = 'Ks';
  static double subtract({required double a, required double b}) {
    if (a.compareTo(b)>0)
      return a - b;
    else
      return 0;
  }


  static final oCcy = new NumberFormat("#,##0", "en_US");

  static String formatCurrency(double? value, {String? currency}) {
    return oCcy.format(value ?? 0) + " " + (currency ?? "MMK");
  }

  static String formatNumber(double? value) {
    return oCcy.format(value ?? 0);
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    return _isEmpty(value);
  }


  static bool _isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool;
    }
    return false;
  }

  static bool isNull(dynamic value) => value == null;

  static bool notNull(List? lst) {
    return lst != null && lst.length > 0;
  }

  static bool isObjectNotNull(Object? object) {
    return object != null;
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String svgPath(String iconName) {
    return "assets/icons/$iconName.svg";
  }

  String rupiahFormater(String value) {
    if (value == null || value == 'null') {
      value = "0";
    }

    double amount = double.parse(value);
    // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
    // String fix = "Rp. " + c.replaceAll(",", ".");
    return value;
  }

  String moneyFormater(String value) {
    if (value == null || value == 'null') {
      value = "0";
    }

    double amount = double.parse(value);
    // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
    // String fix = "" + c.replaceAll(",", ".");
    return value;
  }


  String parseHtmlString(String htmlString) {
    // var document = parse(htmlString);
    // String parsedString = parse(document.body.text).documentElement.text;
    return htmlString;
  }

  String stringCardFormated(
      {String value = "", int splitOn = 3, String modelSplit = " "}) {
    String newValue = "Error Formatting";
    if (value.length < splitOn) {
      newValue = value;
    } else {
      int startIndex = 0;
      int endIndex = splitOn;
      newValue =
          _formating(startIndex, endIndex, value, "", splitOn, modelSplit);
    }
    return newValue;
  }

  String _formating(int startIndex, int endIndex, String value, String temp,
      int splitOn, String modelSplit) {
    if (startIndex == 0 && endIndex >= value.length) {
      temp = value.substring(startIndex, endIndex);
      return temp;
    }
    if (startIndex == 0 && endIndex < value.length) {
      temp = value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    }
    if (startIndex < value.length && endIndex < value.length) {
      temp += "$modelSplit" + value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    } else {
      temp += "$modelSplit" + value.substring(startIndex, value.length);
      return temp;
    }
  }


  static bool doubleValid(double? v) {
    return v != null && v > 0;
  }

  static String hideNumber(String account, {int len = 3}) {
    if (account.length > len) {
      account = "*" * (account.length - len) +
          account.substring(account.length - len);
    }
    return account;
  }
}
