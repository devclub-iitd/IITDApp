import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeptWise extends StatelessWidget {
  // final List<Color> _txtcolor;
  // final List<Color> _cardcolor;
  final double _size;
  final String _course;
  const DeptWise(this._course, this._size);
  @override
  Widget build(BuildContext context) {
    return Icon(
      getIcon(_course),
      size: _size,
      color: getColor(_course),
    );
  }

  static Color getColor(String course) {
    switch (course.substring(0, 2).toLowerCase()) {
      case 'ap':
        return Colors.red;
        break;
      case 'cr':
        return Colors.teal;
        break;
      case 'as':
        return Colors.amber;
        break;
      case 'it':
        return Colors.blueAccent;
        break;
      case 'bb':
        return Colors.brown;
        break;
      case 'be':
        return Colors.cyan;
        break;
      case 'bh':
        return Colors.deepOrange;
        break;
      case 'sb':
        return Colors.purple;
        break;
      case 'bm':
        return Colors.greenAccent;
        break;
      case 'cl':
        return Colors.indigoAccent;
        break;
      case 'cm':
        return Colors.lightBlue;
        break;
      case 'ch':
        return Colors.lightGreen;
        break;
      case 'cv':
        return Colors.lime;
        break;
      case 'co':
        return Colors.orangeAccent;
        break;
      case 'dd':
        return Colors.pinkAccent;
        break;
      case 'el':
        return Colors.amberAccent;
        break;
      case 'es':
        return Colors.amberAccent;
        break;
      case 'hu':
        return Colors.blueGrey;
        break;
      case 'hs':
        return Colors.cyan;
        break;
      case 'ms':
        return Colors.red.withGreen(100);
        break;
      case 'pt':
        return Colors.amberAccent.withRed(100);
        break;
      case 'mt':
        return Colors.pink.withBlue(100);
        break;
      case 'mc':
        return Colors.blue.withAlpha(1000);
        break;
      case 'me':
        return Colors.cyan.withRed(100);
        break;
      case 'py':
        return Colors.green;
        break;
      case 'rd':
        return Colors.purple.withRed(100);
        break;
      case 'ds':
        return Colors.orange.withBlue(100);
        break;
      case 'tx':
        return Colors.yellow.withRed(0);
        break;
      case 've':
        return Colors.green.withBlue(1000);
        break;
      default:
        return Colors.deepOrange.withGreen(100);
        break;
    }
  }

  static IconData getIcon(String course) {
    switch (course.substring(0, 2).toLowerCase()) {
      case 'ap':
        return CupertinoIcons.wrench;
        break;
      case 'cr':
        return CupertinoIcons.waveform_path;
        break;
      case 'as':
        return CupertinoIcons.wind;
        break;
      case 'it':
        return CupertinoIcons.gear_alt;
        break;
      case 'bb':
        return Icons.biotech;
        break;
      case 'be':
        return Icons.biotech;
        break;
      case 'bh':
        return Icons.biotech;
        break;
      case 'sb':
        return Icons.biotech_outlined;
        break;
      case 'bm':
        return Icons.medication;
        break;
      case 'cl':
        return CupertinoIcons.lab_flask;
        break;
      case 'cm':
        return CupertinoIcons.lab_flask;
        break;
      case 'ch':
        return CupertinoIcons.lab_flask;
        break;
      case 'cv':
        return Icons.architecture;
        break;
      case 'co':
        return Icons.devices_rounded;
        break;
      case 'dd':
        return Icons.settings_input_svideo;
        break;
      case 'el':
        return Icons.memory;
        break;
      case 'es':
        return Icons.electrical_services;
        break;
      case 'hu':
        return Icons.face_unlock_sharp;
        break;
      case 'hs':
        return Icons.face_unlock_sharp;
        break;
      case 'ms':
        return Icons.microwave;
        break;
      case 'pt':
        return Icons.polymer;
        break;
      case 'mt':
        return Icons.functions;
        break;
      case 'mc':
        return CupertinoIcons.wrench;
        break;
      case 'me':
        return CupertinoIcons.perspective;
        break;
      case 'py':
        return CupertinoIcons.antenna_radiowaves_left_right;
        break;
      case 'rd':
        return CupertinoIcons.arrow_branch;
        break;
      case 'ds':
        return CupertinoIcons.tuningfork;
        break;
      case 'tx':
        return Icons.people;
        break;
      case 've':
        return CupertinoIcons.rays;
        break;
      default:
        return CupertinoIcons.book;
        break;
    }
  }

  static Icon pageIcon(String course, double sz) {
    return Icon(
      getIcon(course),
      size: sz,
      color: Colors.white,
    );
  }
}
