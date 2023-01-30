// ignore_for_file: missing_required_param
import 'package:flutter/material.dart';
import 'package:doctor_notes/Components/patient_details.dart';
import 'package:doctor_notes/Components/single_visit_details.dart';
import 'package:doctor_notes/Screens/patient_profile.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:doctor_notes/database/doctor_db.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'list_screen.dart';
import 'new_patient.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.changeThemeCallBack});
  final VoidCallback changeThemeCallBack;

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  late AppColors appColors;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void goToVisitsPage() async {
    List<SingleVisitDetails> result = [];
    List<Visit> dbVisits;
    List<Patient> dbPatients;
    dbPatients = await context.read<DoctorDB>().getAllPatients();
    dbVisits =  await context.read<DoctorDB>().getAllVisits();

    for (var visit in dbVisits) {
      Patient? patient;
        for (var p in dbPatients) {
          if (visit.userId == p.uniqueId) {
            patient = p;
          }
        }
      if (patient != null){
        result.add(SingleVisitDetails(visit: visit ,patient: patient,));
      }
    }

    result = result.reversed.toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListScreen(
                  result,
                  title: "Visits",
              withFilter: true,
                )));
  }

  void goToPatientsPage() async {
    List<PatientDetails> result = [];
    List<Patient> dbPatients;
    dbPatients = await context.read<DoctorDB>().getAllPatients();

    for (var p in dbPatients) {
      result.add(PatientDetails(patient: p,));
    }

    result = result.reversed.toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListScreen(
              result,
              title: "All Patients",
            )));
  }

  @override
  Widget build(BuildContext context) {
    appColors = Provider.of<AppColors>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(context.read<AppColors>().pathImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
              ),
              color: context.read<AppColors>().bgColor4Op,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TypeAheadField<Patient>(
                textFieldConfiguration: TextFieldConfiguration(
                  // enableInteractiveSelection: true,
                  controller: searchController,
                  autofocus: false,
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: context.read<AppColors>().color1),
                    decoration: const InputDecoration(border: InputBorder.none)),
                suggestionsCallback: (pattern) async {
                  if (pattern.isNotEmpty) {
                    return await context.read<DoctorDB>().getAllPatientsBySearch(pattern);
                  }
                  return [];
                },
                getImmediateSuggestions: false,
                autoFlipDirection: true,
                keepSuggestionsOnLoading: false,
                hideOnLoading: false,
                keepSuggestionsOnSuggestionSelected: false,
                loadingBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
                noItemsFoundBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'لا توجد نتائج مطابقة للبحث',
                      ),
                    ),
                  ],
                ),
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                    leading: suggestion.isMale ? const Icon(Icons.male, color: Colors.blue,) : const Icon(Icons.female, color: Colors.pink,),
                  );
                }, onSuggestionSelected: (suggestion){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientProfile(patient: suggestion)));
                searchController.clear();
              },
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: context.read<AppColors>().bgColor2,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("resources/image/Final Logo.png"),
                      fit: BoxFit.fitWidth,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: context.read<AppColors>().bgColor5Op,
                          blurRadius: 50)
                    ]),
              ),
            ),
            Column(children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dark'),
                    Switch(
                      activeColor: Colors.blue,
                      splashRadius: 50,
                      value: appColors.isLight,
                      onChanged: (state) {
                        setState(() {
                          appColors.isLight = state;
                          appColors.isLight
                              ? appColors.toLight()
                              : appColors.toDark();
                          widget.changeThemeCallBack();
                        });
                      },
                    ),
                    const Text('Light'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    goToPatientsPage();
                  },
                  child: Row(
                    children: [
                      Text(
                        "Patients",
                        style: TextStyle(
                            color: context.read<AppColors>().color1,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    goToVisitsPage();
                  },
                  child: Row(
                    children: [
                      Text(
                        "All Visits",
                        style: TextStyle(
                            color: context.read<AppColors>().color1,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: context.read<AppColors>().color1,
          onPressed: () {},
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: context.read<AppColors>().color4,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPatient()));
            },
          )),
    );
  }
}
