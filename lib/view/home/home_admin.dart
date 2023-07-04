import 'package:flutter/material.dart';

import '../../controller/user_controller.dart';
import '../log/login.dart';

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
                        onPressed: () => Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Login()
                          )
                        ),
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
        
      ),
    );
  }
}
