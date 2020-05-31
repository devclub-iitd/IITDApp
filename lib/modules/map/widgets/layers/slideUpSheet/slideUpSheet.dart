import 'package:IITDAPP/modules/map/data/slidePanelPosition.dart';
import 'package:IITDAPP/modules/map/widgets/layers/slideUpSheet/slideUpPanelBody.dart';
import 'package:IITDAPP/modules/map/widgets/layers/slideUpSheet/slideUpPanelHeader.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/map/data/mapCondition.dart';

class SlideUpSheet extends StatefulWidget {
  @override
  _SlideUpSheetState createState() => _SlideUpSheetState();
}

class _SlideUpSheetState extends State<SlideUpSheet>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _offsetAnimation;
  int markerToShow;
  PanelController pc = PanelController();
  var canvasHeight;

  void changeHeight() {
    var spp =Provider.of<SlidePanelPosition>(context, listen: false);
    if(_animationController.value<0.02){
      return;
    }
      var h = canvasHeight * 0.15 * _animationController.value;
      
    if(spp.position == h){
      return;
    }
      //TODO check rebuild call during build
      if (pc.isAttached && !pc.isPanelAnimating) {
          // print('position called');
        spp.setPosition(h);
      }
    }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 400), value: 0);
    _animationController.addStatusListener((status) {
      print(status);
    });
    _offsetAnimation =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0, 0.2)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.linear));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.removeListener(changeHeight);
    _animationController.addListener(changeHeight);
    var mc = Provider.of<MapConditions>(context, listen: true);
    var resetScroll = false;
    if (mc.selectedMarker != -1 && !mc.currentLocationVisible && !mc.toggled) {
      // show when geolocation is not enabled and filter menu is changed
      markerToShow = mc.selectedMarker;
      _animationController.forward(from: _animationController.value);
      if (pc.isAttached && pc.isPanelOpen) {
        pc.close(); // starting position should be closed
      }
    } else {
      mc.toggled = false; // visible after changes done
      if (pc.isAttached) {
        pc.close();
        resetScroll = true;
        //TODO Reset Scroll on marker select
      }
      _animationController.reverse(from: _animationController.value);
    }
    var locationDetails;
    if (markerToShow != null) {
      locationDetails = mc.markers[markerToShow].location;
    }
    // print(mc.selectedMarker);
    canvasHeight = MediaQuery.of(context).size.height;
    return markerToShow != null
        ? SlideTransition(
            position: _offsetAnimation,
            child: SlidingUpPanel(
              header: SlideUpPanelHeader(locationDetails: locationDetails),
              controller: pc,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: AppColors.SLIDE_UP_SHEET_COLOR,
              margin: EdgeInsets.symmetric(horizontal: 5),
              panelBuilder: (sc) {
                if (resetScroll) {
                  sc.jumpTo(0);
                  resetScroll = false;
                }
                return SlideUpPanelBody(
                    locationDetails: locationDetails, sc: sc);
              },
              minHeight: canvasHeight * 0.15,
              maxHeight: canvasHeight * 0.5,
              panelSnapping: true,
              isDraggable: true,
            ),
          )
        : Container();
  }
}
