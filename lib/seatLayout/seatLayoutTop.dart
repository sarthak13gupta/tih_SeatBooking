import 'package:flutter/material.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:seat_layout/widgets/parkingSlot.dart';

class SeatLayoutTop extends StatefulWidget {
  final List<Slot> seatTopList;
  const SeatLayoutTop({Key? key, required this.seatTopList}) : super(key: key);

  @override
  State<SeatLayoutTop> createState() => _SeatLayoutTopState();
}

class _SeatLayoutTopState extends State<SeatLayoutTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: 300,
      width: 200,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.3,
          crossAxisSpacing: 20,
          mainAxisExtent: 100,
          mainAxisSpacing: 20,
        ),
        children: <Widget>[
          ...widget.seatTopList.map((value) {
            return ParkingSlot(
              key: ValueKey(value.id),
              available: value.available,
              selected: value.selected,
              slot: value,
            );
          })
        ],
      ),
    );
  }
}
