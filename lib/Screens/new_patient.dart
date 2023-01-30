import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/custom_date_picker.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/classes/patient_info.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import 'new_visit.dart';

class NewPatient extends StatelessWidget {

  final PatientInfo patientInfo = PatientInfo();
  NewPatient({super.key});
  void changeIsMale(bool male) {
    patientInfo.isMale = male;
  }
  void setDateTime(DateTime date) {
    patientInfo.birthday = date;
  }
  @override
  Widget build(BuildContext context) {
    Visit? visit;
    return Scaffold(
      bottomSheet: Container(
        color: context
            .read<AppColors>()
            .color2,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon:const Icon(Icons.check_outlined), onPressed: ()  {
              if(patientInfo.name.text.isNotEmpty&&patientInfo.phone.text.isNotEmpty && patientInfo.birthday != null){
              context.read<DoctorDB>().insertPatient(
                Patient(
                      id: 0,
                      uniqueId: patientInfo.uniqueId,
                      name:patientInfo.name.text,
                      phone:patientInfo.phone.text,
                      patientId: patientInfo.patientId.text,
                     birthday: patientInfo.birthday!,
                    isMale: patientInfo.isMale,
                ),
              );
              if (visit != null) {
                context.read<DoctorDB>().insertVisit(visit!);
              }
              Fluttertoast.showToast(
                  msg: "successfully saved!!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 15,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 20.0);
              Navigator.pop(context);
              }
              else {
                Fluttertoast.showToast(
                    msg: " please enter patient Name, phone Number, and Birthday",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 8,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 20.0);
              }
            }),
            IconButton(icon: Icon(Icons.close), onPressed: () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
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
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: AnimationLimiter(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 2),
                        child: FadeInAnimation(
                          curve: Curves.bounceIn,
                          child: SlideAnimation(
                              child: Padding(
                                padding: const EdgeInsets.all(60.0),
                                child: Column(
                                  children: [

                                    CustomDatePicker(
                                      onConfirmed: (date){
                                        patientInfo.birthday=date;
                                      },
                                      label: "Birthday",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: TextField(
                                          controller: patientInfo.patientId,
                                          decoration: InputDecoration(
                                              hintText: " Patient Id"),
                                        ),
                                        tileColor: context
                                            .read<AppColors>()
                                            .color2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: TextField(
                                          controller: patientInfo.name,
                                          decoration:
                                          InputDecoration(hintText: " Name"),
                                        ),
                                        tileColor: context
                                            .read<AppColors>()
                                            .color2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: TextField(
                                           controller: patientInfo.phone,
                                          decoration: InputDecoration(
                                              hintText: " Phone Number"),
                                        ),
                                        tileColor: context
                                            .read<AppColors>()
                                            .color2,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 80),
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.female),
                                          MaleOrFemale(
                                            onChange: changeIsMale,
                                          ),
                                          Icon(FontAwesomeIcons.male),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TextButton.icon(
                                          onPressed: () async {
                                          visit = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewVisit(patientId: patientInfo.uniqueId,)));
                                          },
                                          icon: const Icon(Icons.message_outlined),
                                          label: const Text(" New Visit")),
                                    )
                                  ],
                                ),
                              )),
                        ));
                  })),
        ),
      ),
    );
  }
}

class MaleOrFemale extends StatefulWidget {
  const MaleOrFemale({super.key, this.onChange, this.isMale = false});
  final bool isMale;
  final Function(bool)? onChange;

  @override
  _MaleOrFemaleState createState() => _MaleOrFemaleState();
}

class _MaleOrFemaleState extends State<MaleOrFemale> {
  late bool male;

  @override
  void initState() {
    super.initState();
    male = widget.isMale;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: Colors.blue,
        inactiveThumbColor: Colors.pink,
        inactiveTrackColor: Colors.pinkAccent,
        splashRadius: 50,
        value: male,
        onChanged: (isMale) {
          setState(() {
            male = isMale;
            widget.onChange?.call(male);
          });
        });
  }
}