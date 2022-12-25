import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:seat_layout/providers/slotProvider.dart';
import 'package:seat_layout/widgets/parkingSlot.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SeatLayoutBottom extends StatefulWidget {
  const SeatLayoutBottom({Key? key}) : super(key: key);

  @override
  State<SeatLayoutBottom> createState() => _SeatLayoutBottomState();
}

class _SeatLayoutBottomState extends State<SeatLayoutBottom> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<SlotProvider>(context);
    final seatBottomList = providerData.seatBottom;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 400,
      child: GridView(
        // padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.3,
          crossAxisSpacing: 20,
          mainAxisExtent: 100,
        ),
        children: <Widget>[
          ...seatBottomList.map((value) {
            return ParkingSlot(ValueKey(value.id), value.available);
          })
        ],
      ),
    );
  }
}
