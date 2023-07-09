import 'package:flutter/material.dart';

import '../../controller/jadwal_controller.dart';
import 'add_jadwal.dart';
import 'jadwal.dart';

class JadwalHome extends StatefulWidget {
  const JadwalHome({Key? key}) : super(key: key);

  @override
  State<JadwalHome> createState() => _JadwalHomeState();
}

class _JadwalHomeState extends State<JadwalHome> {
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
                                Jadwal(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddJadwal(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
