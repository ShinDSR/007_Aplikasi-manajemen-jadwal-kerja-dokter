import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/poli/poli.dart';

import '../../controller/poli_controller.dart';
import '../../model/poli_model.dart';

class EditPoli extends StatefulWidget {
  const EditPoli({
    Key? key,
    this.id,
    this.poliname,
  }) : super(key: key);

  final String? id;
  final String? poliname;

  @override
  State<EditPoli> createState() => _EditPoliState();
}

class _EditPoliState extends State<EditPoli> {
  var poliController = PoliController();
  final formkey = GlobalKey<FormState>();
  String? temppoliname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Poli'),
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
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Poli Name',
                    border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white
                  ),
                  onSaved: (value) {
                    temppoliname = value;
                  },
                  initialValue: widget.poliname,
                ),
                const SizedBox(height: 20),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white)
                        ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        PoliModel pm = PoliModel(
                            id: widget.id,
                            poliname: temppoliname!.toString(),);
                        poliController.EditPoli(pm);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Poli Changed')));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Poli(),
                          ),
                        );
                      }
                    },
                    child: Text('Edit'))
              ],
            ),
          ),
        )
      ),
    );
  }
}