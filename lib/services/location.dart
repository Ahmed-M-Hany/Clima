import 'package:geolocator/geolocator.dart';

class Location {
  double latitude, longitude;

  void getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      // print("pos");
      // print(position);
      // print("mammmamiaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    } catch (e) {
      // print("eeeee");
      // print(e);
    }
  }
}
