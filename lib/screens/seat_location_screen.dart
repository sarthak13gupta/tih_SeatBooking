import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/providers/slotProvider.dart';
import 'package:seat_layout/screens/details_page.dart';
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
  List<Slot> selectedSeatList = [];
  late SlotProvider providerData;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('carSlots')
        .snapshots()
        .listen((event) {
      _fetchProviderData();
    });
  }

  _fetchProviderData() {
    providerData = Provider.of<SlotProvider>(context, listen: false);
    isLoading = true;
    providerData.extractData().then((response) {
      setState(() {
        seatTopList = response.first;
        seatBottomList = response.last;
        selectedSeatList = providerData.selectedSlot;
      });
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    _fetchProviderData();
    return isLoading
        ? const Center(
            child: Text('Loading'),
          )
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Basement 1",
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      child: SeatLayoutTop(seatTopList: seatTopList),
                    ),
                    SizedBox(
                      child: SeatLayoutBottom(seatBottomList: seatBottomList),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    // move to details page
                    selectedSeatList.isNotEmpty
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const DetailsPage()))
                        : null;
                  },
                  label: const Text("Select slot"))
            ],
          );
  }
}
