import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/curtain.dart';
import 'package:doctor_notes/Components/custom_date_picker.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/classes/visit_info.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewVisit extends StatefulWidget {
  const NewVisit({super.key, this.patient, this.patientId});
  final Patient? patient;
  final String? patientId;
  @override
  _NewVisitState createState() => _NewVisitState();
}
class _NewVisitState extends State<NewVisit> {
  late bool isExpanded;
  Visit? visit;
  late VisitInfo visitInfo;
  Patient? patient;
  @override
  void initState() {
    super.initState();
    assert(widget.patient == null || widget.patientId == null, "Either patient or patientId must be given");
    isExpanded = true;
    patient = widget.patient;
    visitInfo = VisitInfo();
  }

  @override
  void dispose() {
    visitInfo.dispose();
    super.dispose();
  }

  void changeIsExpanded(bool isExpanded) {
    this.isExpanded = isExpanded;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(context
                  .read<AppColors>()
                  .pathImage),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 6,
              sigmaY: 6,
            ),
            child: Column(
              children: [
                patient != null ? Curtain(isExpanded: isExpanded,patient: patient!,) : const SizedBox(height: 50,),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      SizedBox(height: 20,),
                      CustomDatePicker(
                        onConfirmed: (date) {
                          visitInfo.visitDate = date;
                        },
                        label: DateFormat("dd/MM/yyyy h:mm a").format(visitInfo.visitDate),
                        dateFormat: "dd/MM/yyyy h:mm a",
                      ),
                      ListTile(
                        title: TextField(
                          controller:visitInfo.pastCase ,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                            });
                          },
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Past Case"),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller:visitInfo.pastMedicine ,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                            });
                          },
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Past Medicines"),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller:visitInfo.pathologicalCase ,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                            });
                          },
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Current Case"),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: visitInfo.treatment,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 3,
                          maxLines: 5,
                          onTap: () {
                            if (isExpanded) {
                              setState(() {
                                isExpanded = false;
                              });
                            }
                          },
                          decoration: InputDecoration(hintText: "Treatment"),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: visitInfo.notes,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 2,
                          maxLines: 5,
                          onTap: () {
                            if (isExpanded) {
                              setState(() {
                                isExpanded = false;
                              });
                            }
                          },
                          decoration: InputDecoration(hintText: "Notes"),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.smoke_free),
                        Switch(
                          value: visitInfo.smoker,
                          onChanged: (isSmoker) {
                          setState(() {
                          visitInfo.smoker = isSmoker;
                        });
                        },
                        inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.blue,
                          activeColor: Colors.red,
                          activeTrackColor: Colors.grey,
                        ),
                        Icon(Icons.smoking_rooms),
                      ],),
                      SizedBox(height: 60,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(child: Icon(Icons.check_outlined), onPressed: () {
              if(
              visitInfo.notes.text.isNotEmpty&&
              visitInfo.pathologicalCase.text.isNotEmpty&&visitInfo.treatment.text.isNotEmpty){
                visit = Visit(
                  pastCase: visitInfo.pastCase.text,
                  pastMedicines: visitInfo.pastMedicine.text,
                  treatment: visitInfo.treatment.text,
                  notes: visitInfo.notes.text,
                  currentCase:visitInfo.pathologicalCase.text,
                  visitDate: visitInfo.visitDate,
                  isSmoker:visitInfo.smoker ,
                  userId: widget.patient?.uniqueId ?? widget.patientId!, id: 0,
                );
                Navigator.pop(context,visit);
              }else{
                Fluttertoast.showToast(
                    msg: "please enter treatment and current case",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 8,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }
            },),
            IconButton(icon: Icon(Icons.close), onPressed: () {
              Navigator.pop(context);
            }),
          ],),
      ),
    );
  }
}
