import 'package:flutter/material.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:age_calculator/age_calculator.dart';

class Curtain extends StatefulWidget {
  const Curtain({super.key, this.isExpanded = true, this.isMale = false,required this.patient});
  final bool isExpanded;
  final bool isMale;
  final Patient patient;
  @override
  _CurtainState createState() => _CurtainState();
}
class _CurtainState extends State<Curtain> {
  late int age;
  late bool isExpanded;
  @override
  void initState() {
    age=AgeCalculator.age(widget.patient.birthday).years;
    isExpanded = widget.isExpanded;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isExpanded ? 270 : 50,
      child: Container(
        width: double.infinity,
       decoration: BoxDecoration( color: context.read<AppColors>().bgColor2Op,
           borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50.0),
         bottomLeft: Radius.circular(50.0),
       ),
          ),
        child: Column(
          children: [
            isExpanded ? Expanded(flex: 2,

              child: Row(
                children: [
                  Expanded(flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(widget.patient.name,style: TextStyle(color: context.read<AppColors>().color4),),
                            subtitle: Text("ID: ${widget.patient.patientId}",style: TextStyle(color: context.read<AppColors>().color3),),
                          ),
                          ListTile(
                            title: Text("Birthday: ${DateFormat('dd/MM/yyyy').format(widget.patient.birthday)}", style: TextStyle(color: context.read<AppColors>().color4),),
                            subtitle: Text("$age yrs",style: TextStyle(color: context.read<AppColors>().color3),),

                          ),
                          ListTile(
                            title: Text(widget.patient.phone,style: TextStyle(color: context.read<AppColors>().color4),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: FittedBox(
                        child: CircleAvatar(
                          radius: 180,
                          backgroundImage:
                         widget.patient.isMale ?  AssetImage("resources/image/person0.jpg"):AssetImage("resources/image/person1.png")
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) : SizedBox(),
            Expanded(
              child: IconButton(
                  icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,color: context.read<AppColors>().color2,),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  }),
            )
          ],
        ),
      ),
    );
      //   : Container(
      // height: 50,
      // width: double.infinity,
      // decoration: BoxDecoration( color:context.read<AppColors>().bgColor2Op ,
      //   borderRadius: BorderRadius.only(
      //     bottomRight: Radius.circular(50.0),
      //     bottomLeft: Radius.circular(50.0),
      //   ),
      // ),
      // child: Center(
      //   child: IconButton(
      //       icon: Icon(Icons.keyboard_arrow_down,color: context.read<AppColors>().color2),
      //       onPressed: () {
      //         setState(() {
      //           isExpanded = true;
      //         });
      //       }),
      // ),);
  }
}
