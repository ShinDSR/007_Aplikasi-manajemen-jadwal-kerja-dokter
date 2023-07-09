import 'package:flutter/material.dart';

import '../../controller/jadwal_controller.dart';
import 'jadwal_user.dart';

class JadwalHomeUser extends StatefulWidget {
  const JadwalHomeUser({Key? key}) : super(key: key);
  @override
  State<JadwalHomeUser> createState() => _JadwalHomeUserState();
}

class _JadwalHomeUserState extends State<JadwalHomeUser> {
  var jc = JadwalController();
  String? selectedDay;

  @override
  void initState() {
    jc.getFromShift();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        backgroundColor: Colors.blueGrey,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 7, // Jumlah item dalam daftar hari (Senin hingga Minggu)
                  itemBuilder: (context, index) {
                    final day = [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                      'Sunday'
                    ][index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JadwalUser(
                              day: day,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              day.substring(0, 2).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(day),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}