import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/providers/slotProvider.dart';
import 'package:seat_layout/seatLayout/seatLayoutBottom.dart';
import 'package:seat_layout/seatLayout/seatLayoutTop.dart';

import '../model/slot.dart';
// import 'package:seat_layout/data/handlingData.dart';

class SeatLocationScreen extends StatefulWidget {
  const SeatLocationScreen({Key? key}) : super(key: key);

  @override
  State<SeatLocationScreen> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SeatLocationScreen> {
  List<Slot> seatTopList = [];
  List<Slot> seatBottomList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('carSlots')
        .snapshots()
        .listen((event) {
      final providerData = Provider.of<SlotProvider>(context, listen: false);
      isLoading = true;
      providerData.extractData().then((response) {
        setState(() {
          seatTopList = response.first;
          seatBottomList = response.last;
        });
        // print('hi');
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return isLoading
        ? const Center(
            child: Text('Loading'),
          )
        : Stack(
            children: <Widget>[
              Positioned(
                left: 10,
                top: 20,
                child: SeatLayoutTop(seatTopList: seatTopList),
              ),
              Positioned(
                left: 10,
                bottom: 200,
                child: SeatLayoutBottom(seatBottomList: seatBottomList),
              ),
              Positioned(
                  left: 150,
                  bottom: 50,
                  child: ElevatedButton(
                      onPressed: (() => {}), child: const Text('book')))
            ],
          );
  }
}
