import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/jadwal/jadwal_home.dart';

import '../../controller/jadwal_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/jadwal_model.dart';

class AddJadwal extends StatefulWidget {
  const AddJadwal({super.key});

  @override
  State<AddJadwal> createState() => _AddJadwalState();
}

class _AddJadwalState extends State<AddJadwal> {
  final formkey = GlobalKey<FormState>();
  var jc = JadwalController();
  var uc = UserController();

  String? shiftname;
  String? username;
  String? day;
  String? poliname;
  List<Map<String, dynamic>>? namesWithSelectedPoli;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Jadwal'),
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
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.calendar_today),
                    hintText: 'Select Day',
                  ),
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      day = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select day';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), //ber
                FutureBuilder<List>(
                  future: jc.getFromUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.person)),
                            hint: const Text("Select name"),
                            value: username,
                            onChanged: (newValue) {
                              setState(() {
                                username = newValue.toString();
                              });
                            },
                            items: snapshot.data!
                                .map((value) => DropdownMenuItem(
                                      child: Text(value['name']),
                                      value: value['name'],
                                    ))
                                .toList(),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                const SizedBox(height: 20),
                FutureBuilder<List>(
                  future: jc.getFromShift(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.numbers),
                            ),
                            hint: const Text("Select shift"),
                            value: shiftname,
                            onChanged: (newValue) {
                              setState(() {
                                shiftname = newValue.toString();
                              });
                            },
                            items: snapshot.data!
                                .map((value) => DropdownMenuItem(
                                      child: Text(value['shiftname']),
                                      value: value['shiftname'],
                                    ))
                                .toList(),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      JadwalModel jadwal = JadwalModel(
                        name: username!,
                        shiftname: shiftname!,
                        day: day!,
                      );
                      jc.addJadwal(jadwal);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JadwalHome(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Add ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
