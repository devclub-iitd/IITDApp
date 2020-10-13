import 'package:flutter/material.dart';

void showSnackbarResult(result, ScaffoldState parentScaffold) {
  if (result != null) {
    parentScaffold
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(duration: Duration(seconds: 2), content: Text('$result')));
  }
}
