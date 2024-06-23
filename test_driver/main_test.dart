import 'package:badgemagic/constants.dart';
import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Future<void> main() async {
  // Connect to flutter driver
  final driver = await FlutterDriver.connect();

  // Setup emulators package
  final emu = await Emulators.build();
  final screenshot = emu.screenshotHelper(
    androidPath: 'screenshots/android',
    iosPath: 'screenshots/ios',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();

    // Clean up the status bar for the device
    await screenshot.cleanStatusBar();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    await driver.close();
  });

  group('Screenshots', () {
    test('Home Screen', () async {
      await driver.waitFor(find.byValueKey(homeScreenTitle));
      await screenshot.capture('01');
    });

    // final buttonFinder = find.byTooltip('Increment');
    // test('updated count', () async {
    //   await driver.tap(buttonFinder);
    //   await driver.tap(buttonFinder);
    //   await driver.tap(buttonFinder);
    //   await driver.waitUntilNoTransientCallbacks();
    //   await screenshot.capture('02');
    // });
  });
}
