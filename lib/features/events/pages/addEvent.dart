// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Form(child: Column(
              children: [
                
              ],
            ))
          ],
        ),
      )),
    );
  }
}