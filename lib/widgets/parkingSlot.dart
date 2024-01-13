import 'package:flutter/material.dart';

class ParkingSlot extends StatefulWidget {
  final bool available;
  const ParkingSlot(Key? key, this.available) : super(key: key);

  @override
  State<ParkingSlot> createState() => _ParkingSlotState();
}

class _ParkingSlotState extends State<ParkingSlot> {
  dynamic color = Colors.green;
  bool selected = false;
  // var Map<String, bool> selectedSeats;

  @override
  Widget build(BuildContext context) {
    if (widget.available == false) {
      color = Colors.red;
    } else if (selected) {
      color = Colors.yellow;
    } else {
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      color: color,
      child: GestureDetector(
        onTap: () {
          // To do
          setState(() {
            selected = !selected;
          });
          print(widget.key);
        },
      ),
    );
  }
}
