import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controller/jadwal_controller.dart';
import '../../model/shift_model.dart';
import '../shift/shift_detail.dart';

class JadwalUser extends StatefulWidget {
  final String? name;
  final String? shiftname;
  final String? day;

  const JadwalUser({
    Key? key, 
    this.name, 
    this.shiftname, 
    this.day,
  }) : super(key: key);

  @override
  State<JadwalUser> createState() => _JadwalUserState();
}

class _JadwalUserState extends State<JadwalUser> {
  var jd = JadwalController();
  String? setDay;

  @override
  void initState() {
    jd.getJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JadwalUser'),
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
                  stream: jd.stream,
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
                        final document = data[index];

                        if (widget.day != null &&
                            (document['day'] != widget.day)) {
                          return Container();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShiftDetail(
                                    shiftModel: ShiftModel.fromMap(data[index].data() as Map<String, dynamic>),
                                    shift:data[index],
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
                                    document['name'].substring(0, 2).toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  document['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  document['shiftname'],
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }}
