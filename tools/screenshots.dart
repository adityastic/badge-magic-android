import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  // Create the config instance
  final emu = await Emulators.build();

  // Shutdown all the running emulators
  await emu.shutdownAll();

  final configs = [
    {'locale': 'en'},
    {'locale': 'fr'},
  ];

  // For each emulator in the list, we run `flutter drive`.
  await emu.forEach([
    'Pixel_8',
    'iPhone 15',
  ])((device) async {
    for (final c in configs) {
      final p = await emu.drive(
        device,
        'test_driver/main.dart',
        config: c,
      );
      stderr.addStream(p.stderr);
      await stdout.addStream(p.stdout);
    }
  });
}
