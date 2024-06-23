import 'dart:io';

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';

var prefix = const String.fromEnvironment('PREFIX');

Future<void> main() async {
  List<String> emulatorIds = [
    'Pixel_8_API_34',
  ];

  await runFlutterScreenshotTests(emulatorIds);
}

Future<void> runFlutterIntegrationTests(
    String deviceId, String deviceName) async {
  const String integrationTestDriver = 'test_driver/test_driver.dart';
  const String integrationTestTarget = 'test_integration/screenshots_test.dart';

  final result = await Process.run('flutter', [
    'drive',
    '-d',
    deviceId,
    '--driver=$integrationTestDriver',
    '--target=$integrationTestTarget',
  ], environment: {
    'DEVICE_NAME': deviceName,
    'PREFIX': prefix
  });
  debugPrint(result.stderr);
  debugPrint(result.stdout);
}

Future<void> runFlutterScreenshotTests(List<String> emulatorIds) async {
  final emulators = await Emulators.build();

  await emulators.forEach(emulatorIds)((device) async {
    DeviceState state = device.state;
    debugPrint("Starting ${state.id}: ${state.name}");
    await runFlutterIntegrationTests(state.id, state.name);
  });
}
