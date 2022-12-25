import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/providers/slotProvider.dart';
import 'package:seat_layout/seatLayout/seatLayoutBottom.dart';
import 'package:seat_layout/seatLayout/seatLayoutTop.dart';
// import 'package:seat_layout/data/handlingData.dart';

class SeatLocationScreen extends StatefulWidget {
  const SeatLocationScreen({Key? key}) : super(key: key);

  @override
  State<SeatLocationScreen> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SeatLocationScreen> {
  @override
  // void initState() {
  //   extractData();
  // }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SlotProvider(),
      child: Stack(
        children: const <Widget>[
          Positioned(
            left: 10,
            top: 20,
            child: SeatLayoutTop(),
          ),
          Positioned(
            left: 10,
            bottom: 200,
            child: SeatLayoutBottom(),
          ),
        ],
      ),
    );
  }
}
