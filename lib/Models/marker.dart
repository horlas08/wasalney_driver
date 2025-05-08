
import 'package:google_maps_flutter/google_maps_flutter.dart';


enum markType { place, eye, brain, multiEyes,location }

class MarkerItem {
  var lat = 0.0;
  var long = 0.0;
  String id = "";
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  bool draggable = false;
  markType type = markType.place;
  int number = 0;

  MarkerItem(this.lat, this.long, this.id, this.icon, this.draggable, this.type,
      this.number);
}