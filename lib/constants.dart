import 'dart:io';
import 'dart:ui';

/// debug tools
String get logTrace =>
    '[LOG_TRACE] ${StackTrace.current.toString().split("\n").toList()[1].split("      ").last}';

double fileSize(File? file) {
  if (file == null) {
    return 0;
  }
  final bytes = file.readAsBytesSync().lengthInBytes;
  final kb = bytes / 1024;
  final mb = kb / 1024;
  // debugPrint("$mb Mo");
  return double.parse(mb.toStringAsFixed(2));
}

/// assets
const assetsImages = "assets/images/";

List<Locale> listSupportedtLocale = const [
  Locale("af"),
  Locale("am"),
  Locale("ar"),
  Locale("az"),
  Locale("be"),
  Locale("bg"),
  Locale("bn"),
  Locale("bs"),
  Locale("ca"),
  Locale("cs"),
  Locale("da"),
  Locale("de"),
  Locale("el"),
  Locale("en"),
  Locale("es"),
  Locale("et"),
  Locale("fa"),
  Locale("fi"),
  Locale("fr"),
  Locale("gl"),
  Locale("ha"),
  Locale("he"),
  Locale("hi"),
  Locale("hr"),
  Locale("hu"),
  Locale("hy"),
  Locale("id"),
  Locale("is"),
  Locale("it"),
  Locale("ja"),
  Locale("ka"),
  Locale("kk"),
  Locale("km"),
  Locale("ko"),
  Locale("ku"),
  Locale("ky"),
  Locale("lt"),
  Locale("lv"),
  Locale("mk"),
  Locale("mg"),
  Locale("ml"),
  Locale("mn"),
  Locale("ms"),
  Locale("nb"),
  Locale("nl"),
  Locale("nn"),
  Locale("no"),
  Locale("pl"),
  Locale("ps"),
  Locale("pt"),
  Locale("ro"),
  Locale("ru"),
  Locale("sd"),
  Locale("sk"),
  Locale("sl"),
  Locale("so"),
  Locale("sq"),
  Locale("sr"),
  Locale("sv"),
  Locale("ta"),
  Locale("tg"),
  Locale("th"),
  Locale("tk"),
  Locale("tr"),
  Locale("tt"),
  Locale("uk"),
  Locale("ug"),
  Locale("ur"),
  Locale("uz"),
  Locale("vi"),
  Locale("zh")
];
