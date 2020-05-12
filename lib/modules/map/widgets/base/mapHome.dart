import 'package:flutter/material.dart';

import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/modules/map/widgets/base/mapHomeSearch.dart';
import 'package:IITDAPP/modules/map/widgets/base/mapLayers.dart';

class MapHome extends StatelessWidget {
  const MapHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('built home');
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Map'),
        actions: [MapHomeSearch()],
      ),
      drawer: AppDrawer(
        tag: 'Campus Map',
      ),
      body: MapLayers(),
    );
  }
}
