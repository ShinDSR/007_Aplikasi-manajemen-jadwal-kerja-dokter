import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/shift_model.dart';

class ShiftDetail extends StatefulWidget {
  ShiftModel shiftModel;
  ShiftDetail({
    Key? key,
    required this.shiftModel,
    required DocumentSnapshot <Object?> shift,
  }) : super(key: key);

  @override
  State<ShiftDetail> createState() => _ShiftDetailState();
}

class _ShiftDetailState extends State<ShiftDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Shift'),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // Tinggi bayangan
                    shadowColor:Colors.black.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Detail Shift',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: widget.shiftModel.shiftname,
                            decoration: const InputDecoration(
                              labelText: 'Shift Name',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: widget.shiftModel.timein,
                            decoration: const InputDecoration(
                              labelText: 'Time In',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: widget.shiftModel.timeout,
                            decoration: const InputDecoration(
                              labelText: 'Time Out',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}