import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_layout/model/slot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotProvider with ChangeNotifier {
  // List<Slot> data = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Slot> _seatTop = [];
  List<Slot> _seatBottom = [];

  void extractData() async {
    print('hi');
    List<Slot> seatTopLocal = [];
    List<Slot> seatBottomLocal = [];
    await firestore
        .collection('carSlots')
        .orderBy('index', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var index = doc['index'];
        var available = doc['available'];
        print(doc.id);
        if (index <= 4) {
          seatTopLocal.add(Slot(doc.id, index, available));
        } else {
          seatBottomLocal.add(Slot(doc.id, index, available));
        }
      });
    });

    _seatTop = seatTopLocal;
    _seatBottom = seatBottomLocal;

    notifyListeners();
  }

  List<Slot> get seatTop {
    return [..._seatTop];
  }

  List<Slot> get seatBottom {
    return [..._seatBottom];
  }
}
