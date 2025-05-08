import 'dart:async';
import 'dart:ui';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/marker-name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/marker.dart';
import 'dart:ui' as ui;

import '../../Models/order.dart';
import '../../Public/images.dart';


class MapApiController extends GetxController {
  static GoogleMapController? mainController;
  static Rx<CameraPosition> camPosition=CameraPosition(target: UserController.myPosition, zoom: 16,).obs;
  static RxMap<String, Marker> markers =<String, Marker>{}.obs;
  static RxList<MarkerItem> markerList = <MarkerItem> [].obs;
  Completer<GoogleMapController> completer = Completer();

  static Rx<String> address=''.obs;
  static Timer timer=Timer(Duration(days: 999), (){});
  int start = 1;
 static setCameraPosition(lat, long) {
    camPosition.value = CameraPosition(
      target: LatLng(double.parse(lat.toString()), double.parse(long.toString())),
      zoom: 16,
    );
    print("lat>>>>>${lat}");
    CameraUpdate updated = CameraUpdate.newCameraPosition(camPosition.value,);
    if (mainController != null) {
      print("mainController not null");
      mainController!.animateCamera(updated);
    }
  }
  static Marker createMarker(var lat, var long, String id, BitmapDescriptor icon,
      markType type, int number, bool dragable) {

    return Marker(
        draggable: dragable,
        onDragEnd: (position) {
          // if (type==markType.place && dragable ) {
          //   myPosition = position;
          //   markers['selectedLocation']=createMarker(position.latitude, position.longitude, id, icon, type, number, dragable);
          // }
        },

        markerId: MarkerId(id),
        position: LatLng(double.parse(lat.toString()), double.parse(long.toString())),
        icon: icon
      //Icon for Marker
    );
  }
  void setPositionMarker(var lat, var long, String id ){
    for (int i = 0; i < markerList.length; i++) {
      if (markerList[i].id == id) {
        markerList[i].lat = lat;
        markerList[i].long = long;
        print('***** ${markerList[i].id} ${markerList[i].lat} ${markerList[i].long}');
        markers[id] = createMarker(lat, long, id, markerList[i].icon,
            markerList[i].type, markerList[i].number, markerList[i].draggable);
      }
    }
  }
  static BitmapDescriptor? iconMap;
  static  addMarker(var lat, var lang, String icon,{String? id,
    markType type = markType.place,
    int number = 0,

    bool dragable = false}) async {
    print('add marker');
    if (kIsWeb)
      iconMap = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(50, 60)), icon);
    else
      iconMap = await createCustomMarkerBitmap(icon);


    markers[id!] = createMarker(double.parse(lat.toString()), double.parse(lang.toString()), id, iconMap!, type, number, dragable);
    MarkerItem markerItem = new MarkerItem(double.parse(lat.toString()), double.parse(lang.toString()), id, iconMap!, dragable, type, number);
    markerList.add(markerItem);
    print('marker is>>${markerList.length}');
    // update();
  }
  static Future<BitmapDescriptor> createCustomMarkerBitmap(String imageURL,{int? markerNumber,bool isMarkerNumber = false}) async {
    int markerWidth;
    int markerHeight;
    if (kIsWeb)
      markerWidth = 50;
    else
      markerWidth = 150;
    markerHeight=200;
    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas c = Canvas(recorder);
    print('dataa1>>${imageURL}');
    final data1 = await rootBundle.load(imageURL);
    print('dataa1>>${data1.buffer}');
    Uint8List d=data1.buffer.asUint8List();
    var markerImage = await decodeImageFromList(d);
    c.drawImageRect(
        markerImage,
        Rect.fromLTRB(0.0, 0.0, markerImage.width.toDouble(),
            markerImage.height.toDouble()),
        Rect.fromLTRB(0.0, 0.0, markerWidth.toDouble(), markerHeight.toDouble()),
        Paint());
    var p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(markerWidth, markerHeight))
        .toByteData(format: ui.ImageByteFormat.png);
    Uint8List data = Uint8List.view(pngBytes!.buffer);
    return BitmapDescriptor.fromBytes(data);
  }

  static removeMarker(String markId){
    if(MapApiController.markers.length>0 && MapApiController.markers[markId]!=null){
      Marker marker = MapApiController.markers[markId]!;
      MapApiController.markers.remove(markId);
    }
    if( MapApiController.markerList.length>1 && MapApiController.markerList.value.any((element) => element.id==markId)){
      MarkerItem markerItem = MapApiController.markerList.value.firstWhere((marker) => marker.id == markId,orElse: null);
      MapApiController.markerList.value.remove(markerItem);
    }
  }
  static removeAllMarker(){
    removeMarker(MarkerName.origin);
    removeMarker(MarkerName.des);
    removeMarker(MarkerName.newDes);
    removeMarker(MarkerName.secDes);
  }
  static setMarker(var lat,var lang,String markerId,String icon,){
    removeMarker(markerId);
    addMarker(double.parse(lat.toString()),double.parse( lang.toString()), icon,id: markerId);
  }

  static addMarkerOrder(Order order){
    MapApiController.removeMarker(MarkerName.origin);
    MapApiController.removeMarker(MarkerName.des);
    MapApiController.removeMarker(MarkerName.newDes);
    MapApiController.removeMarker(MarkerName.secDes);

    double latOrigin=double.parse(order.originLat.toString());
    double langOrigin=double.parse(order.originLong.toString());
    double latDes=double.parse(order.destinationLat.toString());
    double langDes=double.parse(order.destinationLong.toString());
    MapApiController.setMarker(latOrigin, langOrigin, MarkerName.origin, origin_icon);
    MapApiController.setMarker(latDes, langDes, MarkerName.des, destination_icon);
    if(order.info.length>2){
      MapApiController.setMarker(double.parse(order.info[2].lat.toString()), double.parse(order.info[2].long.toString()), MarkerName.secDes, sec_destination_icon);
    }

  }

}
