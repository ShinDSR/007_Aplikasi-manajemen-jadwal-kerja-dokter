import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/shift/shift.dart';

import '../../controller/shift_controller.dart';
import '../../model/shift_model.dart';

class EditShift extends StatefulWidget {
  const EditShift({
    Key? key,
    this.id,
    this.day,
    this.shiftname,
    this.timein,
    this.timeout,
  }) : super(key: key);

  final String? id;
  final String? day;
  final String? shiftname;
  final String? timein;
  final String? timeout;

  @override
  State<EditShift> createState() => _EditShiftState();
}

class _EditShiftState extends State<EditShift> {
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

  var sc = ShiftController();
  final formkey = GlobalKey<FormState>();
  String? tempday;
  String? tempshiftname;
  String? temptimein;
  String? temptimeout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Shift'),
        backgroundColor: Colors.grey,
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
          padding: const EdgeInsets.all(10),
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
                  value: widget.shiftname,
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
                    tempshiftname = value.toString();
                  },
                  onSaved: (value) {
                    tempshiftname = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select shift';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timer_sharp),
                      hintText: widget.timein,  
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
                  onSaved: (value) {
                    temptimein = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timer),
                      hintText: widget.timeout,
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
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select time out'
                      : null,
                  onSaved: (value) {
                    temptimeout = value;
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        ShiftModel sm = ShiftModel(
                          id: widget.id,
                          shiftname: tempshiftname!,
                          timein: temptimein!,
                          timeout: temptimeout.toString(),
                        );
                        sc.EditShift(sm);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Poli Changed')));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Shift(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
