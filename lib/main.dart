// // // lib/main.dart
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'dart:async';

// // import 'package:sentry_flutter/sentry_flutter.dart';

// // Future<void> main() async {
// //   // GitHub Actions will inject these at build time, fallback to default
// //   const release = String.fromEnvironment(
// //     'SENTRY_RELEASE',
// //     defaultValue: 'test_sentry_web@1.0.0+local',
// //   );
// //   const dist = String.fromEnvironment('SENTRY_DIST', defaultValue: 'local');

// //   print('Running with release: $release dist: $dist');

// //   await SentryFlutter.init((options) {
// //     options.dsn =
// //         'https://a6e7985b56f267c8d1eacaff7445120e@o4509711535898624.ingest.de.sentry.io/4509711539568720';
// //     options.environment = kReleaseMode ? 'release' : 'debug';
// //     options.release = release;
// //     options.dist = dist;
// //     options.tracesSampleRate = 1.0;
// //     options.profilesSampleRate = 1.0;
// //   }, appRunner: () => runApp(const CrashDemoApp()));
// // }

// // class CrashDemoApp extends StatelessWidget {
// //   const CrashDemoApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Crash Demo',
// //       theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
// //       home: const CrashButtonsPage(),
// //     );
// //   }
// // }

// // class CrashButtonsPage extends StatelessWidget {
// //   const CrashButtonsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Tap to crash')),
// //       body: ListView(
// //         padding: const EdgeInsets.all(16),
// //         children: [
// //           _CrashButton('NoSuchMethodError', _throwNoSuchMethod),
// //           _CrashButton('RangeError (list)', _throwRangeError),
// //           _CrashButton('Null check failure', _throwNullAssertion),
// //           _CrashButton('Type error', _throwTypeError),
// //           _CrashButton('FlutterError (bad layout)', _throwBadLayout),
// //           _CrashButton('FormatException', _throwFormatException),
// //           _CrashButton('PlatformException', _throwPlatformException),
// //           _CrashButton('TimeoutException', _throwTimeout),
// //           _CrashButton('Unhandled async exception', _throwAsyncException),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _CrashButton extends StatelessWidget {
// //   const _CrashButton(this.label, this.onPressed);
// //   final String label;
// //   final VoidCallback onPressed;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: ElevatedButton(onPressed: onPressed, child: Text(label)),
// //     );
// //   }
// // }

// // // ---------- The crashers ----------
// // void _throwNoSuchMethod() {
// //   // ignore: avoid_dynamic_calls
// //   (42 as dynamic).nonExistingMethod();
// // }

// // void _throwRangeError() {
// //   final list = <int>[1, 2, 3];
// //   // ignore: unused_local_variable
// //   final item = list[100];
// // }

// // void _throwNullAssertion() {
// //   int? value;
// //   // ignore: unused_local_variable
// //   final nonNull = value!;
// // }

// // void _throwTypeError() {
// //   // ignore: unnecessary_cast
// //   final String s = 123 as String;
// // }

// // void _throwBadLayout() {
// //   // A widget that throws during layout
// //   runApp(
// //     MaterialApp(
// //       home: Scaffold(
// //         body: SizedBox(
// //           width: double.infinity,
// //           height: double.infinity,
// //           child: OverflowBox(
// //             maxWidth: -1, // negative dimension -> FlutterError
// //             child: Container(color: Colors.red),
// //           ),
// //         ),
// //       ),
// //     ),
// //   );
// // }

// // void _throwFormatException() {
// //   int.parse('not_a_number');
// // }

// // Future<void> _throwPlatformException() async {
// //   // We simulate a platform channel call that fails.
// //   // ignore: invalid_use_of_visible_for_testing_member
// //   throw Exception('PlatformException(fake, native failed, details)');
// // }

// // Future<void> _throwTimeout() async {
// //   await Future.delayed(
// //     const Duration(seconds: 1),
// //   ).timeout(const Duration(milliseconds: 1));
// // }

// // void _throwAsyncException() async {
// //   // This crash happens in a zone that is NOT awaited in the button handler,
// //   // so the error propagates to FlutterError.onError.
// //   Future.delayed(
// //     const Duration(milliseconds: 200),
// //     () => _throwNullAssertion(),
// //   );
// // }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mediqo/cluade_main.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// import 'package:syncfusion_flutter_calendar/calendar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: ScheduleWithGridPage(),
//       home: MedicalTimeline(),
//     );
//   }
// }

// /// کلاس نوبت بیمار
// class Appointment {
//   final DateTime start, end;
//   final String patient;
//   Appointment({
//     required this.start,
//     required this.end,
//     required this.patient,
//   });
// }

// /// نقاش ساده برای رسم خط عمودی خط‌خور (dashed)
// class DashedLineVerticalPainter extends CustomPainter {
//   final Color color;
//   final double dashHeight, gapHeight;

//   const DashedLineVerticalPainter({
//     this.color = Colors.grey,
//     this.dashHeight = 6.0,
//     this.gapHeight = 4.0,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint p = Paint()
//       ..color = color
//       ..strokeWidth = 1.0;
//     double y = 0;
//     while (y < size.height) {
//       canvas.drawLine(
//         Offset(size.width / 2, y),
//         Offset(size.width / 2, y + dashHeight),
//         p,
//       );
//       y += dashHeight + gapHeight;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter old) => false;
// }

// /// ویجت اصلی
// class HomeApp extends StatefulWidget {
//   const HomeApp({Key? key}) : super(key: key);
//   @override
//   _HomeAppState createState() => _HomeAppState();
// }

// class _HomeAppState extends State<HomeApp> {
//   static final DateTime _firstHour = DateTime(2000, 1, 1, 8);
//   static const int _hoursCount = 16; // از 8 تا 24
//   static const double _cardHeight = 112.0;

//   final List<Appointment> _appointments = [
//     Appointment(
//       start: DateTime(2000, 1, 1, 8, 0),
//       end: DateTime(2000, 1, 1, 8, 50),
//       patient: 'علی',
//     ),
//     Appointment(
//       start: DateTime(2000, 1, 1, 8, 40),
//       end: DateTime(2000, 1, 1, 9, 10),
//       patient: 'محمد',
//     ),
//     // … سایر نوبت‌ها …
//   ];

//   late final List<int> _appointmentCountByHour;
//   final ScrollController _ctrlHours = ScrollController();
//   final ScrollController _ctrlCards = ScrollController();
//   bool _syncing = false;

//   @override
//   void initState() {
//     super.initState();
//     _initCounts();
//     _ctrlHours.addListener(_syncScroll);
//     _ctrlCards.addListener(_syncScroll);
//   }

//   void _initCounts() {
//     _appointmentCountByHour = List.filled(_hoursCount, 0);
//     for (final ap in _appointments) {
//       final startIdx =
//           ap.start.hour.clamp(8, 8 + _hoursCount - 1) - 8;
//       final endIdx = ap.end.hour.clamp(8, 8 + _hoursCount - 1) - 8;
//       for (int i = startIdx; i <= endIdx; i++) {
//         _appointmentCountByHour[i]++;
//       }
//     }
//   }

//   void _syncScroll() {
//     if (_syncing) return;
//     _syncing = true;
//     if (_ctrlHours.hasClients &&
//         (_ctrlCards.position.hasPixels
//             ? _ctrlCards.offset != _ctrlHours.offset
//             : true)) {
//       _ctrlCards.jumpTo(_ctrlHours.offset);
//     } else if (_ctrlCards.hasClients) {
//       _ctrlHours.jumpTo(_ctrlCards.offset);
//     }
//     _syncing = false;
//   }

//   String _formatTime(DateTime dt) {
//     final h = (dt.hour % 12 == 0) ? 12 : (dt.hour % 12);
//     final m = dt.minute.toString().padLeft(2, '0');
//     final suf = dt.hour < 12 ? 'AM' : 'PM';
//     return '$h:$m $suf';
//   }

//   @override
//   void dispose() {
//     _ctrlHours.dispose();
//     _ctrlCards.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalHeight = _hoursCount * _cardHeight;

//     return Scaffold(
//       appBar: AppBar(title: const Text('تقویم کاری')),
//       body: LayoutBuilder(builder: (_, constraints) {
//         return Row(
//           children: [
//             // ── ستون تایم‌لاین (ساعت‌ها) ──
//             SizedBox(
//               width: 80,
//               child: SingleChildScrollView(
//                 controller: _ctrlHours,
//                 child: SizedBox(
//                   height: totalHeight,
//                   child: Stack(
//                     children: [
//                       // خطوط افقی ساعت
//                       for (int i = 0; i <= _hoursCount; i++)
//                         Positioned(
//                           top: i * _cardHeight - 0.5,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             height: 1,
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                       // پرش زمان (شامل AM/PM)
//                       for (int i = 0; i < _hoursCount; i++)
//                         Positioned(
//                           top: i * _cardHeight + 8,
//                           left: 8,
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${(((8 + i) % 12) == 0 ? 12 : ((8 + i) % 12))}:00',
//                                 style:
//                                     const TextStyle(fontSize: 16),
//                               ),
//                               Text(
//                                 (8 + i) < 12 ? 'AM' : 'PM',
//                                 style:
//                                     const TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // ── دیوایدر عمودی خط‌خور (break‑break) ──
//             CustomPaint(
//               size: Size(4, totalHeight),
//               painter: const DashedLineVerticalPainter(
//                 color: Colors.grey,
//                 dashHeight: 8,
//                 gapHeight: 8,
//               ),
//             ),

//             // ── ستون نوبت‌ها ──
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _ctrlCards,
//                 child: SizedBox(
//                   height: totalHeight,
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.stretch,
//                     children: List.generate(_hoursCount, (hourIdx) {
//                       final apps = _appointments
//                           .where((ap) =>
//                               ap.start.hour.clamp(8, 8 + _hoursCount - 1) - 8 ==
//                                   hourIdx ||
//                               (ap.start.hour < 8 &&
//                                   ap.end.hour >= (8 + hourIdx)) ||
//                               (ap.start.hour <= (8 + hourIdx) &&
//                                   ap.end.hour > (8 + hourIdx)))
//                           .toList();
//                       return Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.stretch,
//                         children: apps.map((ap) {
//                           return SizedBox(
//                             height: _cardHeight,
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 4),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       ap.patient,
//                                       style: const TextStyle(
//                                           fontWeight:
//                                               FontWeight.bold),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       '${_formatTime(ap.start)} → ${_formatTime(ap.end)}',
//                                       style: const TextStyle(
//                                           fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

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
