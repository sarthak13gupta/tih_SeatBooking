import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ParkingSlot extends StatelessWidget {
  final bool available;

  ParkingSlot(Key key, this.available) : super(key: key);

  // var color = available == true?
  var color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: color,
      child: GestureDetector(
        onTap: () {
          // To do
        },
      ),
    );
  }
}
