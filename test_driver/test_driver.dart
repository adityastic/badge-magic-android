import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

var prefix = const String.fromEnvironment('PREFIX');

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes,
        [Map<String, Object?>? args]) async {
      final filePath = 'screenshots/$prefix/$screenshotName.png';
      debugPrint('Writing screenshot to $filePath');

      final File image = await File(filePath).create(recursive: true);
      image.writeAsBytesSync(screenshotBytes);
      return true;
    },
  );
}
