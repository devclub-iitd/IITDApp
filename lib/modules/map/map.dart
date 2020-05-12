import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:IITDAPP/modules/map/data/slidePanelPosition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/base/mapHome.dart';

class Map extends StatelessWidget {
  static const String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    print('built map');
    return MultiProvider(providers: [
      ChangeNotifierProvider<MapConditions>(create: (_) => MapConditions()),
      ChangeNotifierProvider<MapOffset>(
        create: (_) => MapOffset(),
      ),
      ChangeNotifierProvider<SlidePanelPosition>(
        create: (_) => SlidePanelPosition(),
      )
    ], child: MapHome());
  }
}

// 16/28.551354/77.178817 16/46817/27340 17/93635/54681 18/187271/109363
// 16/28.537413/77.200599 16/46821/27343 17/93643/54687 18/187287/109375
