import 'package:flutter/material.dart';
import 'package:doctor_notes/Screens/patient_profile.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:provider/provider.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;

  PatientDetails({required this.patient});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 45,
        color: context.read<AppColors>().color3,
        child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>PatientProfile(patient: patient,)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(patient.name,style: TextStyle(fontSize: 18,color: context.read<AppColors>().color1),)),
              const Image(image: AssetImage("resources/image/person0.jpg"))
            ],
          ),
        ),
      ),
    );
  }
}

