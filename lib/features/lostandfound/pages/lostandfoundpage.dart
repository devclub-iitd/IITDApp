import 'package:flutter/material.dart';
import 'package:iitd_app/core/appstate.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/lostandfound/components/lostandfoundcomponents.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:provider/provider.dart';
import 'package:iitd_app/utils/constants.dart';

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  State<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LostAndFoundState>(context, listen: false)
          .fetchLostAndFound();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Lost and Found",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Consumer<LostAndFoundState>(
                  builder: (_, state, child) {
                    if (state.lostandfoundListStatus ==
                        LostAndFoundListStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    } else if (state.lostandfoundListStatus ==
                        LostAndFoundListStatus.error) {
                      return const Center(
                        child: Text("Error"),
                      );
                    } else {
                      return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.65),
                          itemCount: state.lostandfoundList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            LostandFoundModel lostandFoundModel =
                                state.lostandfoundList[i];
                            return LostFoundComponents()
                                .lostCard(lostandFoundModel, context);
                          });
                    }
                  },
                )),
          ],
        ),
      )),
    );
  }
}
