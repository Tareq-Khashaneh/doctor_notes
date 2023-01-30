import 'dart:math'as math;
import 'package:flutter/material.dart';

class PatientInfo {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final math.Random _rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  PatientInfo() {
    name = TextEditingController();
    phone = TextEditingController();
    patientId = TextEditingController();
    uniqueId =  getRandomString(32);
    isMale = false;
  }
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController patientId;
  DateTime? birthday;
  late bool isMale;
  late String uniqueId;
  void dispose() {
    name.dispose();
    phone.dispose();
    patientId.dispose();
  }
}