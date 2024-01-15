import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:seat_layout/providers/slotProvider.dart';

class ParkingSlot extends StatefulWidget {
  final bool available;
  final bool selected;
  final Slot slot;
  const ParkingSlot({
    Key? key,
    required this.available,
    required this.selected,
    required this.slot,
  }) : super(key: key);

  @override
  State<ParkingSlot> createState() => _ParkingSlotState();
}

class _ParkingSlotState extends State<ParkingSlot> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          if (widget.available && !widget.selected) {
            setState(() {
              selected = !selected;
            });
            _modifySelectedList();
          }
        },
        child: SvgPicture.asset(
          widget.available
              ? 'assets/icons/unparked.svg'
              : 'assets/icons/parked.svg',
          color: selected && widget.available
              ? Colors.amber
              : Colors.black, // Replace with your SVG file path
        ),
      ),
    );
  }

  void _modifySelectedList() {
    SlotProvider providerData =
        Provider.of<SlotProvider>(context, listen: false);
    List<Slot> tempSelectedSlots = providerData.selectedSlot;
    if (!selected) {
      List<Slot> updatedSelectedSlots = tempSelectedSlots
          .where((element) => element.id != widget.slot.id)
          .toList();
      tempSelectedSlots = updatedSelectedSlots;
    } else {
      tempSelectedSlots.add(widget.slot);
    }
    providerData.setSelectedSlots(tempSelectedSlots);
  }
}
