import 'package:flutter/material.dart';
import 'package:doctor_notes/classes/app_colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Screens/search_screen.dart';
import 'database/doctor_db.dart';

void main() async {
  await GetStorage.init();
  runApp(MultiProvider(
    providers: [
      Provider<AppColors>(
        create: (_) => AppColors(),
      ),
      Provider<DoctorDB>(
        create: (_) => DoctorDB(),
      ),
    ],
    child: MainMainApp(),
  ));
}

class MainMainApp extends StatefulWidget {
  @override
  _MainMainAppState createState() => _MainMainAppState();
}

class _MainMainAppState extends State<MainMainApp> {
  late ThemeData myTheme;
  late bool isLoaded;
  void changeThemeData() {
    setState(() {
      myTheme = Provider.of<AppColors>(context, listen: false).themeData;
    });
  }

  void loadNextPage() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    isLoaded = false;
    loadNextPage();
    myTheme = context.read<AppColors>().themeData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoaded
          ? MainApp(
              changeThemeCallBack: changeThemeData,
            )
          : Container(
              color: Color(0xff212121),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage("resources/image/doctor officer.png"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CircularProgressIndicator(
                      color: Colors.yellowAccent,
                    ),
                  ],
                ),
              )),
            ),
      theme: myTheme,
    );
  }
}
