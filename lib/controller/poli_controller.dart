import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/poli_model.dart';

class PoliController{
  final poliCollection = FirebaseFirestore.instance.collection('poli');
  final StreamController<List<DocumentSnapshot>> streamController= StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addPoli(PoliModel plModel) async{
    final poli  = plModel.toMap();
    final DocumentReference docref = await poliCollection.add(poli);
    final String docid = docref.id;
    final PoliModel poliModel = PoliModel(
      id: docid,
      poliname: plModel.poliname
    );

    await docref.update(poliModel.toMap());
  }

  Future getPoli() async{
    final poli = await poliCollection.get();
    streamController.sink.add(poli.docs);
    return poli.docs;
  }

  Future deletePoli(String id) async{
    final poli = await poliCollection.doc(id).delete();
    return poli;
  }

  Future EditPoli(PoliModel plmodel) async{
    final PoliModel plModel_update = PoliModel(
      id: plmodel.id,
      poliname: plmodel.poliname
    );

    return await poliCollection.doc(plmodel.id).update(plModel_update.toMap());

  }
}