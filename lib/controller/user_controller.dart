import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jadwal_piket_dokter/controller/poli_controller.dart';

import '../model/user_model.dart';

class UserController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final StreamController<List<DocumentSnapshot>> streamController= StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;
  var poliController = PoliController();

  bool get success => false;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '', 
          phone: snapshot['phone'] ?? '', 
          role: snapshot['role'] ?? '', 
          poli: snapshot['poli'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      //print('Error signIn user: $e');
    }

    return null;
  }

  // Future<UserModel?> updateUser(
  //     String id, 
  //     String email, 
  //     String name, 
  //     String phone, 
  //     String role, 
  //     String poli) async {
  //   try {
  //     final UserModel newUser =
  //         UserModel(id: id, email: email, name: name, phone: phone, role: role, poli: poli);

  //     await userCollection.doc(newUser.id).update(newUser.toMap());

  //     return newUser;
  //   } catch (e) {
  //     print('Error updating user: $e');
  //   }

  //   return null;
  // }

  Future<List> getFromPoli() async{
    var  poli = await poliController.getPoli();
    return poli;
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name, String phone, String role, String poli) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser =
            UserModel(id: user.uid, email: user.email ?? '', name: name, phone: phone, role: role, poli: poli);

        await userCollection.doc(newUser.id).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user: $e');
    }

    return null;
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  // Future<void> signOut(BuildContext context, Future Function() param1) async {
  //   await auth.signOut();
  // }

  Future getUser() async{
    final user = await userCollection.get();
    streamController.sink.add(user.docs);
    return user.docs;
  }

  Future deleteUser(String id) async{
    final user = await userCollection.doc(id).delete();
    return user;
  }
}