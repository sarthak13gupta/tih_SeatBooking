import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:seat_layout/providers/slotProvider.dart';
import 'package:seat_layout/widgets/finalPay.dart';
import 'package:seat_layout/widgets/slotDetail.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _sliderValue = 0.0;
  static const double maxSliderValue = 120.0; // 2 hours in minutes
  late SlotProvider providerData;
  List<Slot> selectedSlotList = [];

  void initState() {
    super.initState();
    _fetchSelectedData();
  }

  void _fetchSelectedData() {
    providerData = Provider.of<SlotProvider>(context, listen: false);
    setState(() {
      selectedSlotList = providerData.selectedSlot;
    });
  }

  @override
  Widget build(BuildContext context) {
    int hours = (_sliderValue / 60).floor();
    int minutes = (_sliderValue % 60).floor();
    _fetchSelectedData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // show data
          Column(
            children: [
              ...selectedSlotList.map(((e) {
                return SlotDetail(selectedSlot: e);
              })),
            ],
          ),
          // show slider for timing
          Column(
            children: [
              const Text(
                "Set Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: _sliderValue,
                onChanged: (double value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                min: 0.0,
                max: maxSliderValue,
                divisions: maxSliderValue.toInt(),
                label: '${hours}:${minutes.toString().padLeft(2, '0')}',
              ),
            ],
          ),

          FinalPay(time: _sliderValue, slotsNum: selectedSlotList.length),
          // show final amount block and button
        ],
      ),
    );
  }
}
