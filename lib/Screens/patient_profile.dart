import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/curtain.dart';
import 'package:doctor_notes/Components/date-details.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:provider/provider.dart';
import 'new_visit.dart';

class PatientProfile extends StatefulWidget {
  final Patient patient;

  const PatientProfile({super.key, required this.patient});

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late bool isExpanded;
  late bool isLoaded;
  late List<Visit> visits;
  late List<Widget> patientVisits;
  @override
  void initState() {
    super.initState();
    isExpanded = true;
    isLoaded = false;
    patientVisits = [];
    getPatientVisitsFromDB();
  }
  void getPatientVisitsFromDB() async {
    DoctorDB doctorDB = context.read<DoctorDB>();
    visits = await doctorDB.getPatientVisits(widget.patient.uniqueId);
    patientVisits = List.generate(
      visits.length,
          (index) => DateDetails(
            patient: widget.patient,
          index: (index + 1).toString(),
          visit: visits[index],
          ),
    );

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      isLoaded = true;
      patientVisits = patientVisits;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(context.read<AppColors>().pathImage),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
            child: Column(
              children: [
                Curtain(
                  patient: widget.patient,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: isLoaded
                        ? (visits.isEmpty
                            ? Center(child: Text("No Visits yet.."))
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(
                                      "Previous visits",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: context
                                              .read<AppColors>()
                                              .color1),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: patientVisits.reversed.toList(),
                                      ),
                                    ),
                                  ]))
                        : Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: context.read<AppColors>().color1,
            onPressed: () {},
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: context.read<AppColors>().color4,
              ),
              onPressed: () async {
                Visit visit = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewVisit(patient: widget.patient,)));
                if (visit != null) {
                  await context.read<DoctorDB>().insertVisit(visit);
                  getPatientVisitsFromDB();
                }
              },
            )),
      ),
    );
  }
}
