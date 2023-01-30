import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/curtain.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VisitDetails extends StatefulWidget {
  final Visit visit;
  final Patient patient;
  const VisitDetails({super.key, required this.visit, required this.patient});
  @override
  _NewVisitState createState() => _NewVisitState();
}
class _NewVisitState extends State<VisitDetails> {
  late bool isExpanded;
  @override
  void initState() {
    isExpanded = true;
    super.initState();
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
              image: AssetImage(context.read<AppColors>().pathImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Curtain(isExpanded: isExpanded,patient: widget.patient,),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.web_asset_rounded,
                              color: context.read<AppColors>().color1,
                            ),
                            Text("Visit Date: " + DateFormat("dd/MM/yyyy h:mm a").format(widget.visit.visitDate)),
                          ],
                        ),
                      ),
                      ListTile(title: Text("Past Medicines:"), subtitle: Text(widget.visit.pastMedicines ?? ""),),
                      ListTile(title: Text("Past Case"), subtitle: Text(widget.visit.pastCase ?? ""),),
                      ListTile(title: Text("Current Case"), subtitle: Text(widget.visit.currentCase ?? ""),),
                      ListTile(title: Text("Treatment"), subtitle: Text(widget.visit.treatment ?? ""),),
                      ListTile(title: Text("Notes"), subtitle: Text(widget.visit.notes ?? ""),),
                      ListTile(title: Text("Smoker?"), subtitle: Text(widget.visit.isSmoker ? "yes" : "no"),),
                      SizedBox(height: 60,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }
}
