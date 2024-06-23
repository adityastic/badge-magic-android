import 'package:emulators/emulators.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart' hide find;
import 'package:integration_test/integration_test.dart';

import 'package:badgemagic/view/homescreen.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const androidScreenshotPath = 'screenshots/store/android';
  const iosScreenshotPath = 'screenshots/store/ios';

  final driver = await FlutterDriver.connect(dartVmServiceUrl: "localhost");
  final emulators = await Emulators.build();
  final screenshot = emulators.screenshotHelper(
    androidPath: androidScreenshotPath,
    iosPath: iosScreenshotPath,
  );

  setUpAll(() async {
    await screenshot.cleanStatusBar();
    await driver.waitUntilFirstFrameRasterized();
  });

  tearDownAll(() async {
    await driver.close();
  });

  takeScreenshot(identifier) async {
    await driver.waitUntilNoTransientCallbacks();
    await screenshot.capture(identifier);
  }

  group('end-to-end test', () {
    test('Navigate and Screenshot', () async {
      final homeScreenTitle =
          find.byValueKey(const ValueKey(HomeScreen.homeScreenTitle));

      await driver.waitFor(homeScreenTitle);

      await takeScreenshot('1_home');
    });
  });
}
