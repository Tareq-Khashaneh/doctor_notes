import 'package:flutter/material.dart';
import 'package:doctor_notes/Constants/colors.dart';
import 'package:get_storage/get_storage.dart';

class AppColors {
  AppColors() {
    var storage = GetStorage();
    if (! storage.hasData("isLight")) {
      storage.writeIfNull("isLight", false);
      storage.save();
    }
    isLight = storage.read("isLight");
    if (isLight) {
      toLight();
    } else {
      toDark();
    }
  }

  // Main colors:
  late Color color1;
  late Color color2;
  late Color color3;
  late Color color4;

// Background Colors:
  late Color bgColor1;
  late Color bgColor2;
  late Color bgColor3;
  late Color bgColor4;

// Background Colors with opacity:
  late Color bgColor1Op;
  late Color bgColor2Op;
  late Color bgColor3Op;
  late Color bgColor4Op;
  late Color bgColor5Op;

  // ------------------
  late bool isLight;
  late ThemeData themeData;
  late String pathImage;

  void toLight() {
    var storage = GetStorage();
    if (storage.read("isLight") == false) {
      storage.write("isLight", true);
      storage.save();
    }

    // Main colors:
    color1 = COLOR1;
    color2 = COLOR2;
    color3 = COLOR3;
    color4 = COLOR4;
    // Background Colors:
    bgColor1 = BGCOLOR1;
    bgColor2 = BGCOLOR2;
    bgColor3 = BGCOLOR3;
    bgColor4 = BGCOLOR4;
    // Background Colors with opacity:
    bgColor1Op = BGCOLOR1OP;
    bgColor2Op = BGCOLOR2OP;
    bgColor3Op = BGCOLOR3OP;
    bgColor4Op = BGCOLOR4OP;
    bgColor5Op = BGCOLOR5OP;
    // -----------
    themeData = ThemeData.light().copyWith(
        primaryColor: const Color(0xFF5682a3),
        backgroundColor: Colors.white,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFe7ebf0)));
    pathImage = ("resources/image/background.jpg");
  }

  void toDark() {
    var storage = GetStorage();
    if (storage.read("isLight") == true) {
      storage.write("isLight", false);
      storage.save();
    }
    // Main colors:
    color1 = COLOR1D;
    color2 = COLOR2D;
    color3 = COLOR3D;
    color4 = COLOR4D;
    // Background Colors:
    bgColor1 = BGCOLOR1D;
    bgColor2 = BGCOLOR2D;
    bgColor3 = BGCOLOR3D;
    bgColor4 = BGCOLOR4D;
    // Background Colors with opacity:
    bgColor1Op = BGCOLOR1OPD;
    bgColor2Op = BGCOLOR2OPD;
    bgColor3Op = BGCOLOR3OPD;
    bgColor4Op = BGCOLOR4OPD;
    bgColor5Op = BGCOLOR5OPD;
    // -----------
    themeData = ThemeData.dark().copyWith(
      canvasColor: const Color(0xff1d2733),
      scaffoldBackgroundColor: bgColor1,
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: Colors.grey,
        primary: const Color(0xff79c8e2),
      ),
    );
    pathImage = ("resources/image/background-Dark.jpg");
  }
}
