import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/modules/map/widgets/base/mapLayers.dart';

class MapHome extends StatelessWidget {
  const MapHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('built home');
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      drawer: AppDrawer(
        tag: 'Campus Map',
      ),
      body: MapLayers(),
    );
  }
}
