import 'package:flutter/material.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Slot> _seatTop = [];
  List<Slot> _seatBottom = [];
  List<Slot> _selectedSlot = [];

  Future<Set<List<Slot>>> extractData() async {
    List<Slot> seatTopLocal = [];
    List<Slot> seatBottomLocal = [];
    await firestore
        .collection('carSlots')
        .orderBy('index', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var index = doc['index'];
        var available = doc['available'];
        var selected = doc['selected'];
        if (index <= 4) {
          seatTopLocal.add(Slot(
              id: doc.id,
              index: index,
              available: available,
              selected: selected));
        } else {
          seatBottomLocal.add(Slot(
            id: doc.id,
            index: index,
            available: available,
            selected: selected,
          ));
        }
      }
    });

    _seatTop = seatTopLocal;
    _seatBottom = seatBottomLocal;

    return {_seatTop, _seatBottom};
  }

  void setSelectedSlots(List<Slot> parkingSlot) {
    _selectedSlot = parkingSlot;
  }

  List<Slot> get selectedSlot {
    return [..._selectedSlot];
  }

  List<Slot> get seatTop {
    return [..._seatTop];
  }

  List<Slot> get seatBottom {
    return [..._seatBottom];
  }
}
