import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/shift/shift.dart';

import '../../controller/shift_controller.dart';
import '../../model/shift_model.dart';

class AddShift extends StatefulWidget {
  const AddShift({super.key});

  @override
  State<AddShift> createState() => _AddShiftState();
}

class _AddShiftState extends State<AddShift> {
  TimeOfDay? selectedTimeIn;
  TimeOfDay? selectedTimeOut;

  Future<void> selectTimeIn(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTimeIn = picked;
      });
    }
  }

  Future<void> selectTimeOut(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTimeOut = picked;
      });
    }
  }

  final formkey = GlobalKey<FormState>();
  var shiftController = ShiftController();

  String? day;
  String? shiftname;
  String? timein;
  String? timeout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shift'),
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
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.numbers),
                      hintText: 'Select Shift'),
                  items: <String>[
                    'Shift 1',
                    'Shift 2',
                    'Shift 3',
                    'Shift 4',
                    'Shift 5',
                    'Shift 6',
                    'Shift 7',
                    'Shift 8',
                    'Shift 9',
                    'Shift 10',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    shiftname = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select shift';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timer_sharp),
                      hintText: 'Select Time In',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                  onTap: () => selectTimeIn(context),
                  controller: TextEditingController(
                    text: selectedTimeIn != null
                        ? '${selectedTimeIn!.format(context)}'
                        : '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select time in';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timer),
                      hintText: 'Select Time Out',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                  onTap: () => selectTimeOut(context),
                  controller: TextEditingController(
                    text: selectedTimeOut != null
                        ? '${selectedTimeOut!.format(context)}'
                        : '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select time out';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          timein = selectedTimeIn!.format(context);
                          timeout = selectedTimeOut!.format(context);
                        });
                        await shiftController.addShift(ShiftModel(
                          shiftname: shiftname!,
                          timein: timein!,
                          timeout: timeout!,
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Shift()));
                      }
                    },
                    child: const Text(
                      'Add Shift',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
