// import 'package:flutter/material.dart';
// import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appointments Table',
//       theme: ThemeData.light(useMaterial3: true),
//       home: const AppointmentTablePage(),
//     );
//   }
// }

// class AppointmentTablePage extends StatelessWidget {
//   const AppointmentTablePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Appointments')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return _StickyHeaderTable(
//               constraints: constraints,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _StickyHeaderTable extends StatefulWidget {
//   final BoxConstraints constraints;

//   const _StickyHeaderTable({required this.constraints});

//   @override
//   State<_StickyHeaderTable> createState() => _StickyHeaderTableState();
// }

// class _StickyHeaderTableState extends State<_StickyHeaderTable> {
//   late ScrollController _verticalController;
//   late ScrollController _horizontalController;

//   @override
//   void initState() {
//     super.initState();
//     _verticalController = ScrollController();
//     _horizontalController = ScrollController();
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalController.dispose();
//     super.dispose();
//   }

//   final List<String> _columns = [
//     'Patient',
//     'Appointment Time',
//     'Billing Suggestions',
//     'Status',
//     'Age',
//     'Actions'
//   ];

//   final List<Map<String, dynamic>> _data = [
//     {
//       'patient': 'Alejandro Gonzalez Inarritu',
//       'time': '6:00 pm',
//       'billing': 'Excision',
//       'status': 'Completed',
//       'age': 25,
//     },
//     {
//       'patient': 'Daniel Day-Lewis',
//       'time': '6:00 pm',
//       'billing':
//           'Heart condition monitoring\nSurgical consultation\nRecovery plan',
//       'status': 'Arrived',
//       'age': 25,
//     },
//     {
//       'patient': 'Adrien Brody',
//       'time': '6:00 pm',
//       'billing':
//           'Heart condition monitoring\nSurgical consultation\nRecovery plan',
//       'status': 'Booked',
//       'age': 25,
//     },
//     {
//       'patient': 'Marion Cotillard',
//       'time': '6:00 pm',
//       'billing': 'Surgical consultation',
//       'status': 'Booked',
//       'age': 25,
//     },
//     {
//       'patient': 'Adrien Brody',
//       'time': '6:00 pm',
//       'billing': 'Immunisation',
//       'status': 'Draft',
//       'age': 25,
//     },
//     {
//       'patient': 'Marion Cotillard',
//       'time': '6:00 pm',
//       'billing': 'Tele Health',
//       'status': 'Booked',
//       'age': 25,
//     },
//   ];

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Completed':
//         return Colors.green;
//       case 'Arrived':
//         return Colors.blue;
//       case 'Draft':
//         return Colors.orange;
//       case 'Booked':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       controller: _verticalController,
//       thumbVisibility: true,
//       child: Scrollbar(
//         controller: _horizontalController,
//         thumbVisibility: true,
//         notificationPredicate: (notification) => notification.depth == 1,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           controller: _horizontalController,
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minWidth: widget.constraints.maxWidth),
//             child: Column(
//               children: [
//                 // Header
//                 Container(
//                   // color: Theme.of(context).colorScheme.surfaceVariant,
//                   child: Row(
//                     children: _columns.map((column) {
//                       return Container(
//                         width: _getColumnWidth(column),
//                         padding: const EdgeInsets.all(16),
//                         child: Text(
//                           column,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 // Body
//                 Expanded(
//                   child: SingleChildScrollView(
//                     controller: _verticalController,
//                     child: Column(
//                       children: _data.map((row) {
//                         return Row(
//                           children: [
//                             Container(
//                               width: _getColumnWidth('Patient'),
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.amber,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     row['patient'],
//                                   ),
//                                   Text(
//                                     '${row['age']}',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: _getColumnWidth('Appointment Time'),
//                               padding: const EdgeInsets.all(16),
//                               child: Text(row['time']),
//                             ),
//                             Container(
//                               width: _getColumnWidth('Billing Suggestions'),
//                               padding: const EdgeInsets.all(16),
//                               child: Text(row['billing']),
//                             ),
//                             Container(
//                               width: _getColumnWidth('Status'),
//                               padding: const EdgeInsets.all(16),
//                               child: Chip(
//                                 label: Text(row['status']),
//                                 backgroundColor: _getStatusColor(row['status'])
//                                     .withOpacity(0.15),
//                                 labelStyle: TextStyle(
//                                   color: _getStatusColor(row['status']),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: _getColumnWidth('Age'),
//                               padding: const EdgeInsets.all(16),
//                               child: Text('${row['age']}'),
//                             ),
//                             Container(
//                               width: _getColumnWidth('Actions'),
//                               padding: const EdgeInsets.all(16),
//                               child: IconButton(
//                                 icon: const Icon(Icons.more_horiz),
//                                 onPressed: () {},
//                               ),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double _getColumnWidth(String column) {
//     switch (column) {
//       case 'Patient':
//         return 200;
//       case 'Appointment Time':
//         return 120;
//       case 'Billing Suggestions':
//         return 200;
//       case 'Status':
//         return 120;
//       case 'Age':
//         return 80;
//       case 'Actions':
//         return 100;
//       default:
//         return 150;
//     }
//   }
// }
