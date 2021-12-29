import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeptWise extends StatelessWidget {
  final double size;
  final String dept;
  const DeptWise({this.dept, this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(
      getIcondata(dept),
      size: size,
      color: getColor(dept),
    );
  }

  static Color getColor(String dept) {
    switch (dept) {
      case 'ap':
        return Color(0xaafe4a49);
        break;
      case 'am':
        return Color(0xaafed766);
        break;
      case 'co':
        return Color(0xff011f4b);
        break;
      case 'el':
        return Color(0xff005b96);
        break;
      case 'mc':
        return Color(0xaa851e3e);
        break;
      case 'es':
        return Color(0xaa0e9aa7);
        break;
      case 'tx':
        return Color(0xfffe8a71);
        break;
      case 'ml':
        return Color(0xff4b86b4);
        break;
      case 'cl':
        return Color(0xfffe9c8f);
        break;
      case 'dt':
        return Color(0xff009688);
        break;
      case 'hs':
        return Color(0xff65c3ba);
        break;
      case 'cv':
        return Color(0xffee4035);
        break;
      case 'mt':
        return Color(0xfff37736);
        break;
      case 'py':
        return Color(0xff7bc043);
        break;
      case 'bb':
        return Color(0xff0392cf);
        break;
      case 'ds':
        return Color(0xff4d648d);
        break;
      case 'hu':
        return Color(0xffe0a899);
        break;
      case 'sb':
        return Color(0xff96ceb4);
        break;
      case 'si':
        return Color(0xffffeead);
        break;
      case 'sp':
        return Color(0xffff6f69);
        break;
      case 'as':
        return Color(0xffffcc5c);
        break;
      case 'ms':
        return Color(0xff854442);
        break;
      case 'rd':
        return Color(0xfffff4e6);
        break;
      case 'jr':
        return Color(0xff3c2f2f);
        break;
      case 'bm':
        return Color(0xff3b5998);
        break;
      case 've':
        return Color(0xff8b9dc3);
        break;
      case 'cr':
        return Color(0xff008744);
        break;
      case 'ch':
        return Color(0xff0057e7);
        break;
      case 'cm':
        return Color(0xffd62d20);
        break;
      case 'pt':
        return Color(0xffffa700);
        break;
      case 'jp':
        return Color(0xffff8b94);
        break;
      case 'jc':
        return Color(0xffffd3b6);
        break;
      case 'jo':
        return Color(0xffd11141);
        break;
      case 'md':
        return Color(0xff00b159);
        break;
      case 'ct':
        return Color(0xfff37735);
        break;
      case 'jv':
        return Color(0xffffc425);
        break;
      case 'jt':
        return Color(0xff76b4bd);
        break;
      case 'js':
        return Color(0xffff77aa);
        break;
      case 'nl':
        return Color(0xffff5588);
        break;
      case 'ni':
        return Color(0xffff3377);
        break;
      case 'ne':
        return Color(0xff29abab);
        break;
      case 'bs':
        return Color(0xff4f372d);
        break;
      case 'vl':
        return Color(0xff8874a3);
        break;
      default:
        return Color(0xff64a1f4);
        break;
    }
  }

  static IconData getIcondata(String dept) {
    switch (dept) {
      case 'ap':
        return CupertinoIcons.wrench;
        break;
      case 'am':
        return CupertinoIcons.gear;
        break;
      case 'co':
        return Icons.laptop_mac_rounded;
        break;
      case 'el':
        return Icons.memory;
        break;
      case 'mc':
        return Icons.precision_manufacturing_outlined;
        break;
      case 'es':
        return Icons.power;
        break;
      case 'tx':
        return CupertinoIcons.scissors;
        break;
      case 'ml':
        return Icons.network_check_sharp;
        break;
      case 'cl':
        return CupertinoIcons.lab_flask;
        break;
      case 'dt':
        return Icons.cabin;
        break;
      case 'hs':
        return Icons.psychology;
        break;
      case 'cv':
        return CupertinoIcons.tree;
        break;
      case 'mt':
        return Icons.functions_rounded;
        break;
      case 'py':
        return CupertinoIcons.waveform_path_ecg;
        break;
      case 'bb':
        return Icons.biotech;
        break;
      case 'ds':
        return Icons.design_services;
        break;
      case 'hu':
        return Icons.psychology_outlined;
        break;
      case 'sb':
        return Icons.biotech_outlined;
        break;
      case 'si':
        return Icons.accessibility_rounded;
        break;
      case 'sp':
        return Icons.yard;
        break;
      case 'as':
        return Icons.waves;
        break;
      case 'ms':
        return Icons.holiday_village;
        break;
      case 'rd':
        return Icons.holiday_village_outlined;
        break;
      case 'jr':
        return Icons.emoji_emotions;
        break;
      case 'bm':
        return Icons.medication_rounded;
        break;
      case 've':
        return Icons.pregnant_woman_outlined;
        break;
      case 'cr':
        return CupertinoIcons.lightbulb;
        break;
      case 'ch':
        return CupertinoIcons.lab_flask_solid;
        break;
      case 'cm':
        return CupertinoIcons.lab_flask;
        break;
      case 'pt':
        return Icons.polymer;
        break;
      case 'jp':
        return Icons.countertops;
        break;
      case 'jc':
        return Icons.wifi_tethering_outlined;
        break;
      case 'jo':
        return CupertinoIcons.tuningfork;
        break;
      case 'md':
        return CupertinoIcons.waveform_path_ecg;
        break;
      case 'ct':
        return CupertinoIcons.waveform_circle;
        break;
      case 'jv':
        return CupertinoIcons.antenna_radiowaves_left_right;
        break;
      case 'jt':
        return Icons.electrical_services;
        break;
      case 'js':
        return CupertinoIcons.umbrella_fill;
        break;
      case 'nl':
        return CupertinoIcons.barcode;
        break;
      case 'ni':
        return CupertinoIcons.ellipsis_vertical_circle_fill;
        break;
      case 'ne':
        return CupertinoIcons.selection_pin_in_out;
        break;
      case 'bs':
        return CupertinoIcons.xmark_shield;
        break;
      case 'vl':
        return CupertinoIcons.tornado;
        break;
      default:
        return Icons.people;
        break;
    }
  }

  static Icon pageIcon(String dept, double sz) {
    return Icon(
      getIcondata(dept),
      size: sz,
      color: Colors.white,
    );
  }
}
