import 'package:flutter/material.dart';
import 'package:doctor_notes/Screens/visit-details.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SingleVisitDetails extends StatelessWidget {
  final Patient patient;
  final Visit visit;

  const SingleVisitDetails({super.key, required this.patient,required this.visit});
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
                MaterialPageRoute(builder: (context) =>VisitDetails(visit: visit,patient: patient,)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(patient.name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18,color: context.read<AppColors>().color1),)),
              Expanded(child: FittedBox(fit: BoxFit.scaleDown,child: Text(DateFormat("dd/MM/yyyy h:mma").format(visit.visitDate),style: TextStyle(fontSize: 18,color: context.read<AppColors>().color1),))),
            ],
          ),
        ),
      ),
    );
  }
}

