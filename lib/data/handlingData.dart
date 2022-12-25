// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/material.dart';
// import 'package:seat_layout/seatLayout/seatLayoutTop.dart';

// class CarSlotInfo {
// //   const CarSlotInfo({Key? key}) : super(key: key);
// //   @override
// //   State<CarSlotInfo> createState() => _CarSlotInfoState();
// // }

// // class _CarSlotInfoState extends State<CarSlotInfo> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   List<dynamic> seatTop = [];
//   List<dynamic> seatBottom = [];

//   @override
//   void initState() {
//     // super.initState();
//     firestore.collection('carSlots').snapshots().listen((event) {
//       extractData();
//     });
//   }

//   void extractData() async {
//     List<dynamic> seatTopLocal = [];
//     List<dynamic> seatBottomLocal = [];
//     await firestore
//         .collection('carSlots')
//         .orderBy('index', descending: false)
//         // .where('index', isLessThanOrEqualTo: 4)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       // seatTop = querySnapshot;
//       querySnapshot.docs.forEach((doc) {
//         // print(doc.id);
//         // print(doc['index']);
//         // print(doc['available']);
//         var index = doc['index'];
//         var available = doc['available'];

//         if (index <= 4) {
//           seatTopLocal.add({'index': index, 'available': available});
//         } else {
//           seatBottomLocal.add({'index': index, 'available': available});
//         }
//       });
//     });

//     setState(() {
//       seatTop = seatTopLocal;
//       seatBottom = seatBottomLocal;
//       // print(seatTop);
//       // print(seatBottom);
//     });
//   }

//   // Widget build(BuildContext context) {
//   //   return (const Scaffold());
//   // }
// }
