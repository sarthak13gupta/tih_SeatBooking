import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/widgets/parkingSlot.dart';
import 'package:seat_layout/providers/slotProvider.dart';

class SeatLayoutTop extends StatefulWidget {
  const SeatLayoutTop({Key? key}) : super(key: key);

  @override
  State<SeatLayoutTop> createState() => _SeatLayoutTopState();
}

class _SeatLayoutTopState extends State<SeatLayoutTop> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<SlotProvider>(context);
    providerData.extractData();
    final seatTopList = providerData.seatTop;

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
          ...seatTopList.map<dynamic>(
              (value) => ParkingSlot(ValueKey(value.id), value.available)),
        ],
      ),
    );
  }
}
