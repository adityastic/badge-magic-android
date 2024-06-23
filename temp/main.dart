// ignore_for_file: avoid_print

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:badgemagic/main.dart' as app;

void main() {
  // Disable the 'debug' banner
  WidgetsApp.debugAllowBannerOverride = false;

  // Enable flutter driver
  enableFlutterDriverExtension();

  final locale = Environment.getString('locale');
  print('Device: ${Environment.device}');
  print('Locale: $locale');

  // Run the app.
  app.main();
}
