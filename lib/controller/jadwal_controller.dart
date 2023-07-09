import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jadwal_piket_dokter/controller/shift_controller.dart';
import 'package:jadwal_piket_dokter/controller/user_controller.dart';

import '../model/jadwal_model.dart';

class JadwalController{
  final jadwalCollection = FirebaseFirestore.instance.collection('jadwal');
  final StreamController<List<DocumentSnapshot>> streamController= StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;
  var shiftController = ShiftController();
  var userController = UserController();

  Future<List> getFromUser() async{
    var user = await userController.getUser();
    return user;
  }

  Future<List> getFromShift() async{
    var shift = await shiftController.getShift();
    return shift;
  }

    Future<List> getFromJadwal() async{
    var jadwal = await getJadwal();
    return jadwal;
  }

  Future<void> addJadwal(JadwalModel jdModel) async{
    final jadwal  = jdModel.toMap();
    final DocumentReference docref = await jadwalCollection.add(jadwal);
    final String docid = docref.id;
    final JadwalModel jadwalModel = JadwalModel(
      id: docid,
      day: jdModel.day,
      shiftname: jdModel.shiftname,
      name: jdModel.name,
    );

    await docref.update(jadwalModel.toMap());
  }

  Future<List> getJadwal() async{
    final jadwal = await jadwalCollection.get();
    streamController.sink.add(jadwal.docs);
    return jadwal.docs;
  }

  Future deleteJadwal(String id) async{
    final jadwal = await jadwalCollection.doc(id).delete();
    return jadwal;
  }

  Future EditJadwal(JadwalModel jdmodel) async{
    final JadwalModel jdModel_update = JadwalModel(
      id: jdmodel.id,
      day: jdmodel.day,
      shiftname: jdmodel.shiftname,
      name: jdmodel.name,
    );

    return await jadwalCollection.doc(jdmodel.id).update(jdModel_update.toMap());

  }
}