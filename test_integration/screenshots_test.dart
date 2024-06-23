import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:badgemagic/constants.dart';
import 'utils.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    return Future(() async {
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
      }
    });
  });

  group('E2E Group', () {
    testWidgets('Take Screenshots', (tester) async {
      final homeScreenTitle = find.byKey(const ValueKey(homeScreenTitleKey));

      await pumpUntilFound(tester, homeScreenTitle);
      await binding.takeScreenshot('01');
    });
  });
}
