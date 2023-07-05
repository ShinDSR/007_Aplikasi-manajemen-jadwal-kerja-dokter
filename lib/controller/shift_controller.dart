import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/shift_model.dart';

class ShiftController{
  final shiftCollection = FirebaseFirestore.instance.collection('shift');
  final StreamController<List<DocumentSnapshot>> streamController= StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addShift(ShiftModel shModel) async{
    final shift  = shModel.toMap();
    final DocumentReference docref = await shiftCollection.add(shift);
    final String docid = docref.id;
    final ShiftModel shiftModel = ShiftModel(
      id: docid,
      shiftname: shModel.shiftname, 
      timein: shModel.timein,
      timeout: shModel.timeout,
    );

    await docref.update(shiftModel.toMap());
  }

  Future getShift() async{
    final shift = await shiftCollection.get();
    streamController.sink.add(shift.docs);
    return shift.docs;
  }

  Future deleteShift(String id) async{
    final shift = await shiftCollection.doc(id).delete();
    return shift;
  }

  Future EditShift(ShiftModel shmodel) async{
    final ShiftModel shModel_update = ShiftModel(
      id: shmodel.id,
      shiftname: shmodel.shiftname, 
      timein: shmodel.timein,
      timeout: shmodel.timeout,
    );

    return await shiftCollection.doc(shmodel.id).update(shModel_update.toMap());

  }
}