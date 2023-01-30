import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/single_visit_details.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen(this.data, {super.key, this.title = "", this.withFilter = false});

  final List<Widget> data;
  final String title;
  final bool withFilter;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  late List<Widget> data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  void filterData(int days) async {
    List<SingleVisitDetails> result = [];
    List<Visit> dbVisits =  await context.read<DoctorDB>().getAllVisitsFromDate(DateTime.now().subtract(Duration(days: days)));
    List<Patient> dbPatients = await context.read<DoctorDB>().getAllPatients();
    for (var visit in dbVisits) {
      Patient? patient;
      for (var p in dbPatients) {
        if (visit.userId == p.uniqueId) {
          patient = p;
        }
      }
      if (patient != null) {
        result.add(SingleVisitDetails(visit: visit ,patient: patient,));
      }
    }
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appColors = context.read<AppColors>();
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.withFilter
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    PopupMenuButton(
                      icon: Icon(Icons.filter_alt_sharp,
                          color: appColors.color1, size: 30),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('last one month'),
                          value: 1,
                          onTap: () {
                            filterData(30);
                          },
                        ),
                        PopupMenuItem(
                          child: Text('last 6 months'),
                          value: 2,
                          onTap: () {
                            filterData(180);
                          },
                        ),
                        PopupMenuItem(
                          child: Text('last one year'),
                          value: 3,
                          onTap: () {
                            filterData(365);
                          },
                        ),
                      ],
                    )
                  ],
                )
              : SizedBox(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(context.read<AppColors>().pathImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 45,
                      color: context.read<AppColors>().color1,
                      child: Center(
                          child: Text(
                        widget.title,
                        style: TextStyle(
                            color: context.read<AppColors>().color4,
                            fontSize: 20),
                      )),
                    ),
                    Expanded(
                      child: widget.data.isNotEmpty
                          ? AnimationLimiter(
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return AnimationConfiguration
                                      .staggeredList(
                                    position: index,
                                    duration: const Duration(seconds: 1),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 2),
                                          child: data[index],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text("no Data"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
            color: context.read<AppColors>().color1,
          ),
        ],
      ),
    ));
  }
}
