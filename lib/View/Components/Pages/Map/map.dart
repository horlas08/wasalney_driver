import 'dart:async';

import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/map-controller.dart';
import '../../../../Logic/Controllers/order-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';

import '../../../../Public/images.dart';
import '../../General/img.dart';

class MainMap extends StatelessWidget {
  LatLng? position;
  bool hasMarkers;
  MainMap({this.position,this.hasMarkers=true});
  GoogleMapController? mapController;

  // GoogleMapController? _controller;
  OrderController orderController=Get.put(OrderController());
  MapApiController mapApiController=Get.put(MapApiController());
  @override
  Widget build(BuildContext context) {
    // MapController controller=MapController();
    var size=MediaQuery.of(context).size;
    return
      Obx( () {
        return GoogleMap(
          // scrollGesturesEnabled:true,
          tiltGesturesEnabled: true,
          trafficEnabled: false,
          indoorViewEnabled: true,
          compassEnabled: false,
          // rotateGesturesEnabled: true,

          myLocationEnabled: true,
          onCameraMoveStarted: (){
            // MainController.onPositionChange.value=true;
          },

          onTap: (position,) {
            FocusManager.instance.primaryFocus?.unfocus();

          },

          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),

          initialCameraPosition: MapApiController.camPosition.value,
          markers: this.hasMarkers?MapApiController.markers.values.toSet():Set(),
          onMapCreated: (GoogleMapController controller)async {

            mapApiController.completer.complete(controller);


            MapApiController.mainController = controller;
            print('object');
          },
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,

          // zoomControlsEnabled: false,
        );
      }
      );
  }
}