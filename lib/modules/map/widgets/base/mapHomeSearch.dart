import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/data/dataSearch.dart';
import 'package:provider/provider.dart';

class MapHomeSearch extends StatelessWidget {
  const MapHomeSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mc = Provider.of<MapConditions>(context, listen: false);
    var mo = Provider.of<MapOffset>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: IconButton(
        icon: Icon(Icons.search),
        onPressed: () => showSearch(
          context: context,
          delegate: DataSearch(conditions: mc, offsets: mo),
          query: null,
        ),
      ),
    );
  }
}
