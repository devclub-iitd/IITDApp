import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:iitd_app/features/lostandfound/components/lostandfoundcomponents.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  State<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: lostandfoundlist().length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    LostandFoundModel lostandFoundModel = lostandfoundlist()[i];
                    return LostFoundComponents()
                        .lostCard(lostandFoundModel, context);
                  })
            ],
          ),
        ),
      )),
    );
  }
}
