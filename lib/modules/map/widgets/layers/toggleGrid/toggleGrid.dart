import 'package:IITDAPP/modules/map/widgets/layers/toggleGrid/toggleIcon.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';

class ToggleGrid extends StatelessWidget {
  const ToggleGrid({
    Key key,
    @required Animation<double> scaleAnimation,
  })  : _scaleAnimation = scaleAnimation,
        super(key: key);

  final Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    var mc = Provider.of<MapConditions>(context, listen: false);
    var typeIndex = mc.typeIndex;
    var selected = mc.typesVisible;
    // print(selected);
    var counter = 0;
    return SizedBox(
      height: 150,
      width: 150,
      child: ScaleTransition(
        scale: _scaleAnimation,
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Provider.of<ThemeModel>(context).theme.TOGGLE_GRID_COLOR,
          ),
          child: GridView.count(
              padding: EdgeInsets.all(5),
              crossAxisCount: 3,
              shrinkWrap: true,
              children: typeIndex
                  .map((type) => Marker.getIcon(type).icon)
                  .map((widget) {
                final index = ++counter - 1;

                return ToggleIcon(
                  iconData: widget,
                  colors: [
                    Provider.of<ThemeModel>(context)
                        .theme
                        .TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR,
                    Provider.of<ThemeModel>(context)
                        .theme
                        .TOGGLE_GRID_BUTTON_ICON_COLOR
                  ],
                  selected: selected[index],
                  onTap: () => mc.toggleType(index),
                );
              }).toList()),
        ),
      ),
    );
  }
}
