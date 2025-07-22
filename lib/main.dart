// lib/main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // GitHub Actions will inject these at build time, fallback to default
  const release = String.fromEnvironment(
    'SENTRY_RELEASE',
    defaultValue: 'test_sentry_web@1.0.0+local',
  );
  const dist = String.fromEnvironment('SENTRY_DIST', defaultValue: 'local');

  print('Running with release: $release dist: $dist');

  await SentryFlutter.init((options) {
    options.dsn =
        'https://a6e7985b56f267c8d1eacaff7445120e@o4509711535898624.ingest.de.sentry.io/4509711539568720';
    options.environment = kReleaseMode ? 'release' : 'debug';
    options.release = release;
    options.dist = dist;
    options.tracesSampleRate = 1.0;
    options.profilesSampleRate = 1.0;
  }, appRunner: () => runApp(const CrashDemoApp()));
}

class CrashDemoApp extends StatelessWidget {
  const CrashDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crash Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const CrashButtonsPage(),
    );
  }
}

class CrashButtonsPage extends StatelessWidget {
  const CrashButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap to crash')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _CrashButton('NoSuchMethodError', _throwNoSuchMethod),
          _CrashButton('RangeError (list)', _throwRangeError),
          _CrashButton('Null check failure', _throwNullAssertion),
          _CrashButton('Type error', _throwTypeError),
          _CrashButton('FlutterError (bad layout)', _throwBadLayout),
          _CrashButton('FormatException', _throwFormatException),
          _CrashButton('PlatformException', _throwPlatformException),
          _CrashButton('TimeoutException', _throwTimeout),
          _CrashButton('Unhandled async exception', _throwAsyncException),
        ],
      ),
    );
  }
}

class _CrashButton extends StatelessWidget {
  const _CrashButton(this.label, this.onPressed);
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

// ---------- The crashers ----------
void _throwNoSuchMethod() {
  // ignore: avoid_dynamic_calls
  (42 as dynamic).nonExistingMethod();
}

void _throwRangeError() {
  final list = <int>[1, 2, 3];
  // ignore: unused_local_variable
  final item = list[100];
}

void _throwNullAssertion() {
  int? value;
  // ignore: unused_local_variable
  final nonNull = value!;
}

void _throwTypeError() {
  // ignore: unnecessary_cast
  final String s = 123 as String;
}

void _throwBadLayout() {
  // A widget that throws during layout
  runApp(
    MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: OverflowBox(
            maxWidth: -1, // negative dimension -> FlutterError
            child: Container(color: Colors.red),
          ),
        ),
      ),
    ),
  );
}

void _throwFormatException() {
  int.parse('not_a_number');
}

Future<void> _throwPlatformException() async {
  // We simulate a platform channel call that fails.
  // ignore: invalid_use_of_visible_for_testing_member
  throw Exception('PlatformException(fake, native failed, details)');
}

Future<void> _throwTimeout() async {
  await Future.delayed(
    const Duration(seconds: 1),
  ).timeout(const Duration(milliseconds: 1));
}

void _throwAsyncException() async {
  // This crash happens in a zone that is NOT awaited in the button handler,
  // so the error propagates to FlutterError.onError.
  Future.delayed(
    const Duration(milliseconds: 200),
    () => _throwNullAssertion(),
  );
}
