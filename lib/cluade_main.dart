// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:iconsax_plus/iconsax_plus.dart';
// import 'dart:async';

// class VisitData {
//   final int id;
//   final String patientName;
//   final int age;
//   final String gender;
//   final String startTime;
//   final String endTime;
//   final String status;
//   final List<String> services;
//   final List<String> tags;
//   final String billing;

//   VisitData({
//     required this.id,
//     required this.patientName,
//     required this.age,
//     required this.gender,
//     required this.startTime,
//     required this.endTime,
//     required this.status,
//     required this.services,
//     required this.tags,
//     required this.billing,
//   });
// }

// class MedicalTimeline extends StatefulWidget {
//   const MedicalTimeline({super.key});

//   @override
//   State<MedicalTimeline> createState() => _MedicalTimelineState();
// }

// class _MedicalTimelineState extends State<MedicalTimeline> {
//   late Timer _timer;
//   DateTime _currentTime = DateTime.now();
//   final ScrollController _verticalScrollController = ScrollController();
//   final ScrollController _horizontalScrollController2 = ScrollController();
//   final ScrollController _horizontalScrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     // به‌روزرسانی هر دقیقه
//     _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
//       setState(() {
//         _currentTime = DateTime.now();
//       });
//     });

//     // اسکرول به زمان فعلی پس از رندر شدن
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToCurrentTime();
//     });
//     _horizontalScrollController2.addListener(
//       () {
//         if (_horizontalScrollController.offset !=
//             _horizontalScrollController2.offset) {
//           setState(() {
//             _horizontalScrollController
//                 .jumpTo(_horizontalScrollController2.offset);
//           });
//         }
//       },
//     );
//     _horizontalScrollController.addListener(
//       () {
//         if (_horizontalScrollController.offset !=
//             _horizontalScrollController2.offset) {
//           setState(() {
//             _horizontalScrollController2
//                 .jumpTo(_horizontalScrollController.offset);
//           });
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _verticalScrollController.dispose();
//     _horizontalScrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToCurrentTime() {
//     final position = _calculateCurrentTimePosition();
//     if (_verticalScrollController.hasClients && position > 0) {
//       _verticalScrollController.animateTo(
//         position,
//         duration: const Duration(milliseconds: 800),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   double _calculateCurrentTimePosition() {
//     final timeSlots = generateTimeSlots();
//     final groupedVisits = groupVisitsByHour();
//     double totalHeight = 0.0;

//     int currentHour = _currentTime.hour;
//     int currentMinute = _currentTime.minute;

//     for (int i = 0; i < timeSlots.length; i++) {
//       final slot = timeSlots[i];
//       final visitsInSlot = groupedVisits[slot['value']] ?? [];

//       double slotHeight = 29.0;
//       if (visitsInSlot.isNotEmpty) {
//         slotHeight += visitsInSlot.length * 112.0;
//         slotHeight += (visitsInSlot.length - 1) * 12.0;
//       } else {
//         slotHeight = 112.0;
//       }

//       if (slot['value'] == currentHour) {
//         double positionInSlot = (currentMinute / 60.0) * slotHeight;
//         return totalHeight + positionInSlot - 200;
//       } else if (slot['value'] < currentHour ||
//           (slot['value'] == 0 && currentHour >= 12)) {
//         totalHeight += slotHeight;
//       } else {
//         break;
//       }
//     }

//     return totalHeight;
//   }

//   Widget _buildTimeIndicatorForTimelineSlot(
//       Map<String, dynamic> slot, List<VisitData> visitsInSlot) {
//     int currentHour = _currentTime.hour;

//     // فقط برای ساعت فعلی نشانگر نمایش داده شود
//     if (slot['value'] != currentHour || currentHour < 8 || currentHour > 24) {
//       return const SizedBox.shrink();
//     }

//     int currentMinute = _currentTime.minute;

//     double slotHeight = 29.0;
//     if (visitsInSlot.isNotEmpty) {
//       slotHeight += visitsInSlot.length * 112.0;
//       slotHeight += (visitsInSlot.length - 1) * 12.0;
//     } else {
//       slotHeight = 112.0;
//     }

//     double positionInSlot = (currentMinute / 60.0) * slotHeight;

//     // فرمت زمان فعلی
//     String currentTimeString =
//         "${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}";

//     return Positioned(
//       top: positionInSlot,
//       left: 15,
//       right: 0,
//       child: Row(
//         children: [
//           // CustomPaint(
//           //   size: const Size(40, 16),
//           //   painter: ArrowAndTextPainter(
//           //     arrowColor: $colors.neutral140,
//           //     text: currentTimeString,
//           //     // textStyle: context.textTheme.labelSmall!.copyWith(
//           //     //   fontWeight: FontWeight.w500,
//           //     //   color: Colors.white,
//           //     // ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   // نمونه داده‌های ویزیت (بدون تغییر)
//   final List<VisitData> visits = [
//     VisitData(
//       id: 1,
//       patientName: "Alejandro González Iñarritu",
//       age: 25,
//       gender: "Female",
//       startTime: "8:00",
//       endTime: "8:15",
//       status: "Completed",
//       services: ["Medication compliance", "Blood pressure management"],
//       tags: ["Pediatrics", "Completed"],
//       billing: "\$270 | 10%",
//     ),
//     VisitData(
//       id: 2,
//       patientName: "Daniel Day-Lewis",
//       age: 45,
//       gender: "Female",
//       startTime: "9:00",
//       endTime: "9:15",
//       status: "Arrived",
//       services: [
//         "Heart condition monitoring",
//         "Surgical Consultation",
//         "Recovery plan"
//       ],
//       tags: ["Election", "Arrived"],
//       billing: "Not Generated",
//     ),
//     VisitData(
//       id: 2,
//       patientName: "Daniel Day-Lewis",
//       age: 45,
//       gender: "Female",
//       startTime: "9:20",
//       endTime: "9:40",
//       status: "Arrived",
//       services: [
//         "Heart condition monitoring",
//         "Surgical Consultation",
//         "Recovery plan"
//       ],
//       tags: ["Election", "Arrived"],
//       billing: "Not Generated",
//     ),
//     VisitData(
//       id: 2,
//       patientName: "Daniel Day-Lewis",
//       age: 45,
//       gender: "Female",
//       startTime: "9:45",
//       endTime: "9:55",
//       status: "Arrived",
//       services: [
//         "Heart condition monitoring",
//         "Surgical Consultation",
//         "Recovery plan"
//       ],
//       tags: ["Election", "Arrived"],
//       billing: "Not Generated",
//     ),
//     VisitData(
//       id: 3,
//       patientName: "Adrien Brody",
//       age: 25,
//       gender: "Female",
//       startTime: "10:00",
//       endTime: "10:30",
//       status: "Draft",
//       services: [
//         "Heart condition monitoring",
//         "Surgical consultation",
//         "Recovery plan"
//       ],
//       tags: ["Immunisation", "Draft"],
//       billing: "\$270 | 10%",
//     ),
//     VisitData(
//       id: 4,
//       patientName: "Marion Cotillard",
//       age: 25,
//       gender: "Female",
//       startTime: "10:30",
//       endTime: "11:00",
//       status: "Booked",
//       services: [
//         "Surgical consultation",
//         "Heart condition monitoring",
//         "Recovery plan"
//       ],
//       tags: ["Tele Health", "Booked"],
//       billing: "Not Generated",
//     ),
//     VisitData(
//       id: 5,
//       patientName: "Adrien Brody",
//       age: 25,
//       gender: "Female",
//       startTime: "11:00",
//       endTime: "11:30",
//       status: "Draft",
//       services: [
//         "Heart condition monitoring",
//         "Surgical consultation",
//         "Recovery plan"
//       ],
//       tags: ["Immunisation", "Draft"],
//       billing: "\$270 | 10%",
//     ),
//     VisitData(
//       id: 6,
//       patientName: "Marion Cotillard",
//       age: 25,
//       gender: "Female",
//       startTime: "12:00",
//       endTime: "12:30",
//       status: "Booked",
//       services: [
//         "Heart condition monitoring",
//         "Surgical consultation",
//         "Recovery plan"
//       ],
//       tags: ["Tele Health", "Booked"],
//       billing: "Not Generated",
//     ),
//   ];

//   // تولید ساعات از 8 صبح تا 12 شب (بدون تغییر)
//   List<Map<String, dynamic>> generateTimeSlots() {
//     List<Map<String, dynamic>> slots = [];
//     for (int i = 8; i <= 24; i++) {
//       int hour = i > 12 ? i - 12 : i;
//       String period = i >= 12 ? 'PM' : 'AM';
//       if (i == 24) {
//         slots.add({
//           'time': '12',
//           'period': 'AM',
//           'value': 0,
//         });
//       } else {
//         slots.add({
//           'time': '$hour',
//           'period': period,
//           'value': i,
//         });
//       }
//     }
//     return slots;
//   }

//   // گروه‌بندی ویزیت‌ها بر اساس ساعت شروع (بدون تغییر)
//   Map<int, List<VisitData>> groupVisitsByHour() {
//     Map<int, List<VisitData>> grouped = {};

//     for (var visit in visits) {
//       int startHour = int.parse(visit.startTime.split(':')[0]);
//       if (!grouped.containsKey(startHour)) {
//         grouped[startHour] = [];
//       }
//       grouped[startHour]!.add(visit);
//     }

//     return grouped;
//   }

//   // رنگ‌بندی بر اساس وضعیت (بدون تغییر)
//   Color getStatusColor(String status) {
//     switch (status) {
//       case 'Completed':
//         return const Color(0xFFEFF9F4);
//       case 'Draft':
//         return Colors.blueGrey;
//       case 'Booked':
//         return Colors.blueGrey;
//       default:
//         return Colors.grey;
//     }
//   }

//   Color getStatusBorderColor(String status) {
//     switch (status) {
//       case 'Completed':
//         return Colors.green.shade200;
//       case 'Arrived':
//         return Colors.purple.shade200;
//       case 'Draft':
//         return Colors.grey.shade200;
//       case 'Booked':
//         return Colors.pink.shade200;
//       default:
//         return Colors.grey.shade200;
//     }
//   }

//   Color getTagColor(String tag) {
//     switch (tag) {
//       case 'Completed':
//         return Colors.green;
//       case 'Pediatrics':
//         return Colors.blue;
//       case 'Election':
//         return Colors.orange;
//       case 'Arrived':
//         return Colors.purple;
//       case 'Immunisation':
//         return Colors.teal;
//       case 'Draft':
//         return Colors.grey;
//       case 'Tele Health':
//         return Colors.pink;
//       case 'Booked':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   Widget buildVisitCard(VisitData visit) {
//     return Container(
//       height: 112,
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: visit.status == 'Arrived' ? null : getStatusColor(visit.status),
//         gradient: visit.status == 'Arrived'
//             ? LinearGradient(
//                 colors: [
//                   const Color(0xFFDD5B4F).withValues(alpha: .1),
//                   const Color(0xFF7731D8).withValues(alpha: .1),
//                   const Color(0xFFCD1F86).withValues(alpha: .1),
//                   const Color(0xFFF16F63).withValues(alpha: .1),
//                 ],
//               )
//             : null,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: SizedBox(
//               width: 710,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     spacing: 16,
//                     children: [
//                       Text(
//                         visit.patientName,
//                         // style: context.textTheme.titleSmall!.copyWith(
//                         //   color: $colors.primary100,
//                         // ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Container(
//                         height: 20,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 4, vertical: 2),
//                         decoration: BoxDecoration(
//                           // color: $colors.neutralLight,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           visit.status,
//                           // style: context.textTheme.titleSmall!.copyWith(
//                           //   color: $colors.neutral80,
//                           //   fontSize: 11,
//                           // ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Gap(8),
//                   Text(
//                     '${visit.gender} | Age ${visit.age}',
//                     // style: context.textTheme.titleSmall!.copyWith(
//                     //   color: $colors.neutral120,
//                     //   fontSize: 11,
//                     // ),
//                   ),
//                   const Gap(12),
//                   Wrap(
//                     spacing: 4,
//                     runSpacing: 4,
//                     children: visit.tags
//                         .map(
//                           (tag) => Container(
//                             height: 20,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 4, vertical: 2),
//                             decoration: BoxDecoration(
//                               // color: $colors.neutralLight,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               tag,
//                               // style: context.textTheme.titleSmall!.copyWith(
//                               //   color: $colors.neutral80,
//                               //   fontSize: 11,
//                               // ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             flex: 2,
//             // width: 350,
//             child: Column(
//               spacing: 8,
//               children: [
//                 Row(
//                   spacing: 4,
//                   children: [
//                     Icon(
//                       Icons.access_time,
//                       size: 12,
//                       // color: $colors.neutral120,
//                     ),
//                     Text(
//                       visit.startTime,
//                       // style: context.textTheme.labelMedium!.copyWith(
//                       //   color: $colors.neutral120,
//                       // ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   spacing: 4,
//                   children: [
//                     Icon(
//                       IconsaxPlusLinear.timer,
//                       size: 12,
//                       // color: $colors.neutral120,
//                     ),
//                     Text(
//                       visit.endTime,
//                       // style: context.textTheme.labelMedium!.copyWith(
//                       //   color: $colors.neutral120,
//                       // ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   spacing: 4,
//                   children: [
//                     Icon(
//                       IconsaxPlusLinear.timer_1,
//                       size: 12,
//                       // color: $colors.neutral120,
//                     ),
//                     Text(
//                       visit.startTime,
//                       // style: context.textTheme.labelMedium!.copyWith(
//                       //   color: $colors.neutral120,
//                       // ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             flex: 2,
//             // width: 300,
//             child: Row(
//               spacing: 8,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Wrap(
//                         spacing: 6,
//                         runSpacing: 6,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 4, vertical: 2),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               gradient: LinearGradient(
//                                 colors: [
//                                   const Color(0xFF521D9A)
//                                       .withValues(alpha: 0.2),
//                                   const Color(0xFF7731D8)
//                                       .withValues(alpha: 0.2),
//                                   const Color(0xFFFAA61A)
//                                       .withValues(alpha: 0.2),
//                                   const Color(0xFFCD1F86)
//                                       .withValues(alpha: 0.2),
//                                 ],
//                               ),
//                             ),
//                             child: Row(
//                               spacing: 2,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // const GradientText(
//                                 //   'title',
//                                 //   gradient: LinearGradient(
//                                 //     colors: [
//                                 //       Color(0xFFDD5B4F),
//                                 //       Color(0xFF7731D8),
//                                 //       Color(0xFFCD1F86),
//                                 //       Color(0xFFF16F63),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Icon(
//                                     IconsaxPlusLinear.close_circle,
//                                     size: 12,
//                                     // color: $colors.neutral100,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(height: 8),
//                       // Directionality(
//                       //   textDirection: TextDirection.rtl,
//                       //   child: CustomTextButton(
//                       //     text: 'Add More',
//                       //     icon: IconsaxPlusLinear.add,
//                       //     size: ComponentSizes.sm,
//                       //     buttonType: ButtonType.cta,
//                       //     onPressed: () {},
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   spacing: 14,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: ShaderMask(
//                         blendMode: BlendMode.srcIn,
//                         shaderCallback: (bounds) =>
//                             const LinearGradient(colors: [
//                           Color(0xFFDD5B4F),
//                           Color(0xFF7731D8),
//                           Color(0xFFCD1F86),
//                           Color(0xFFF16F63),
//                         ]).createShader(bounds),
//                         child: const Icon(
//                           IconsaxPlusLinear.eye,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 32,
//                       width: 32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color(0xFFDD5B4F),
//                             Color(0xFF7731D8),
//                             Color(0xFFCD1F86),
//                             Color(0xFFF16F63),
//                           ],
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                         ),
//                       ),
//                       child: const Icon(
//                         IconsaxPlusLinear.arrow_right_3,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return SizedBox(
//       height: 60,
//       child: Row(
//         children: [
//           // قسمت ثابت هدر timeline
//           Container(
//             width: 60,
//             color: Colors.white,
//             child: const SizedBox(),
//           ),
//           // قسمت قابل اسکرول هدر
//           Expanded(
//             child: SingleChildScrollView(
//               controller: _horizontalScrollController2,
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width < 800 ? 1200 : 1600,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Text(
//                           'Patient',
//                           // style: context.textTheme.labelMedium!
//                           //     .copyWith(color: $colors.neutral80),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           'Appointment Time',
//                           // style: context.textTheme.labelMedium!
//                           //     .copyWith(color: $colors.neutral80),
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           'Billing Suggestions',
//                           // style: context.textTheme.labelMedium!
//                           //     .copyWith(color: $colors.neutral80),
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final timeSlots = generateTimeSlots();
//     final groupedVisits = groupVisitsByHour();
//     log(MediaQuery.maybeOf(context)?.size.width.toString() ?? '');

//     return Scaffold(
//       body: Column(
//         children: [
//           // Table Header - Fixed at top
//           _buildTableHeader(),
//           // Scrollable content
//           Expanded(
//             child: SingleChildScrollView(
//               controller: _verticalScrollController,
//               scrollDirection: Axis.vertical,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // بخش تایم‌لاین سمت چپ - ثابت
//                   Container(
//                     width: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border(
//                         right: BorderSide(width: 0.5),
//                       ),
//                     ),
//                     child: Column(
//                       children: timeSlots.map((slot) {
//                         final visitsInSlot = groupedVisits[slot['value']] ?? [];
//                         double slotHeight = 29.0;
//                         if (visitsInSlot.isNotEmpty) {
//                           slotHeight += visitsInSlot.length * 112.0;
//                           slotHeight += (visitsInSlot.length - 1) * 12.0;
//                         } else {
//                           slotHeight = 112.0;
//                         }
//                         return SizedBox(
//                           height: slotHeight,
//                           child: Stack(
//                             children: [
//                               Center(
//                                   child: RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: '${slot['time']}\n',
//                                       style: TextStyle(
//                                         color: Colors.grey.shade600,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: slot['period'],
//                                       style: TextStyle(
//                                         color: Colors.grey.shade600,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                               // نشانگر زمان فقط برای timeline
//                               _buildTimeIndicatorForTimelineSlot(
//                                   slot, visitsInSlot),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   // بخش کارت‌ها - قابل اسکرول افقی
//                   Expanded(
//                     child: SizedBox(
//                       width:
//                           MediaQuery.of(context).size.width < 800 ? 1200 : 1600,
//                       child: Container(
//                         color: Colors.white,
//                         child: Column(
//                           children: timeSlots.map((slot) {
//                             final visitsInSlot =
//                                 groupedVisits[slot['value']] ?? [];
//                             double slotHeight = 29.0;
//                             if (visitsInSlot.isNotEmpty) {
//                               slotHeight += visitsInSlot.length * 112.0;
//                               slotHeight += (visitsInSlot.length - 1) * 12.0;
//                             } else {
//                               slotHeight = 112.0;
//                             }

//                             return Container(
//                               height: slotHeight,
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                     color: Colors.grey.shade200,
//                                     width: 0.5,
//                                   ),
//                                 ),
//                               ),
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 child: visitsInSlot.isEmpty
//                                     ? Center(
//                                         child: Text(
//                                           'No visits scheduled',
//                                           style: TextStyle(
//                                             color: Colors.grey.shade400,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       )
//                                     : Column(
//                                         children: visitsInSlot
//                                             .map((visit) =>
//                                                 buildVisitCard(visit))
//                                             .toList(),
//                                       ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // کلاس برای رسم فلش
// class ArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     path.moveTo(0, size.height / 2 - 6);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(0, size.height / 2 + 6);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
