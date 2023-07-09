import 'package:flutter/material.dart';

import '../../controller/user_controller.dart';
import '../log/login.dart';
import '../poli/poli.dart';
import '../shift/shift.dart';
import '../user/user_for_admin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final form = GlobalKey<FormState>();
  var auth = UserController();

  @override
  void initState() {
    auth.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Admin'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              //
            },
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
                        'Data Poli',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Poli()));
                      }),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      child: const Text(
                        'Data User',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserForAdmin()));
                      }
                    )
                ],
              ),
              const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    ElevatedButton(
                        child: const Text(
                          'Data Shift',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 46, vertical: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.redAccent)),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Shift()));
                        }),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        child: const Text(
                          'Data Jadwal',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 39, vertical: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.redAccent)),
                        ),
                        onPressed: () {
                          
                        })
                  ],
                )
            ]),
          ),
        )),
      ),
    );
  }
}
