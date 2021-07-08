/// flutter:
///   fonts:
///    - family:  MyFlutterApp
///      fonts:
///       - asset: fonts/MyFlutterApp.ttf
///
///
///
import 'package:flutter/widgets.dart';

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  // ignore: constant_identifier_names, avoid_redundant_argument_values
  static const IconData no_virus = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
