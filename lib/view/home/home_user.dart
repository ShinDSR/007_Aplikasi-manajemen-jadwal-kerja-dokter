import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/user/user_for_user.dart';

import '../../controller/user_controller.dart';
import '../log/login.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final form = GlobalKey<FormState>();
  var auth = UserController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home User'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login())),
                        child: Text('Ya'.toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Tidak'.toUpperCase()),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF000000),
              Color(0xFF1A237E),
              Color(0xFF673AB7),
            ],
          ),
        ),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: form,
            child: Column(children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 5),
                  ElevatedButton(
                      child: const Text(
                        'Jadwal Masuk',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                      onPressed: () {
                        // 
                      }
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      child: const Text(
                        'Dokter List',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserForUser()));
                      })
                ],
              ),
            ]),
          ),
        )),
      ),
    );
  }
}
