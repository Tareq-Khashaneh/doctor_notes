import 'package:flutter/material.dart';

class VisitInfo{
  VisitInfo(){
    notes=TextEditingController();
    treatment=TextEditingController();
    pathologicalCase=TextEditingController();
    pastCase=TextEditingController();
    pastMedicine=TextEditingController();
    smoker=false;
    visitDate = DateTime.now();
  }
  late TextEditingController notes;
  late TextEditingController treatment;
  late TextEditingController pathologicalCase;
  late TextEditingController pastCase;
  late TextEditingController pastMedicine;
  late bool smoker;
  late DateTime visitDate;

  void dispose(){
    pastCase.dispose();
    pastMedicine.dispose();
    treatment.dispose();
    notes.dispose();
    pathologicalCase.dispose();
  }

}