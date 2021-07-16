// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void showSnackbarResult(result, ScaffoldState parentScaffold) {
  if (result != null) {
    parentScaffold.removeCurrentSnackBar();
    parentScaffold.showSnackBar(
        SnackBar(duration: Duration(seconds: 2), content: Text('$result')));
  }
}
