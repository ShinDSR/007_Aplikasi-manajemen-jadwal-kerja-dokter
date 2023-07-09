import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controller/shift_controller.dart';

class Shift extends StatefulWidget {
  const Shift({super.key});

  @override
  State<Shift> createState() => _ShiftState();
}

class _ShiftState extends State<Shift> {
  var sc = ShiftController();

  @override
  void initState() {
    sc.getShift();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Shift'),
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
                  child: StreamBuilder<List<DocumentSnapshot>>(
                    stream: sc.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final List<DocumentSnapshot> data = snapshot.data!;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                //
                              },
                              child: Card(
                                elevation: 8,
                                child: ListTile(
                                  title: Text(data[index]['shiftname'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(data[index]['timein'], style: const TextStyle(fontStyle: FontStyle.italic),),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          //
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          sc.deleteShift(data[index].id);
                                          sc.getShift();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
