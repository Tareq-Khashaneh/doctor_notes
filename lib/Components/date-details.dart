import 'package:flutter/material.dart';
import 'package:doctor_notes/Screens/visit-details.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateDetails extends StatelessWidget {
  final Visit visit;
  final Patient patient;
  final String index;
  const DateDetails({super.key, required this.index,required this.visit, required this.patient});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>VisitDetails(visit: visit,patient: patient,) ));},
      title: Text(
        DateFormat("dd/MM/yyyy h:mm a").format(visit.visitDate),
        style: TextStyle(fontSize: 18,color:context.read<AppColors>().color1),
      ),
      leading: Text(index, style: TextStyle(fontSize: 18,color:context.read<AppColors>().color1),),
    );
  }
}
