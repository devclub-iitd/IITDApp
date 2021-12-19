import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:IITDAPP/modules/roles/widgets/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
// import 'package:IITDAPP/modules/roles/widgets/user.dart';
import 'package:IITDAPP/modules/roles/data/data.dart';

class Manage extends StatefulWidget {
  final String org;

  const Manage(this.org);
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  Widget appBar;
  @override
  void initState() {
    appBar = CustomAppBar(
      title: Text('Manage Roles'),
      height: 1,
      withMenu: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(widget.org, 30),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            Column(
              children: [
                for (int j = 0;
                    j <
                        (data.containsKey(widget.org.toLowerCase())
                            ? data[widget.org.toLowerCase()].length
                            : 0);
                    j++)
                  Roles(data[widget.org.toLowerCase()].keys.toList()[j],
                      widget.org),
                Container(height: 40)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
