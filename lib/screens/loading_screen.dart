import 'dart:convert';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double a, b;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getLocation();
    });
  }

  Future<void> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied|| permission==LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    // Geolocator.openLocationSettings();
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);

    double latitude = position.latitude;
    double longitude = position.longitude;
    // Location location = Location();
    // await location.getCurrentLocation();
    a = latitude;
    b = longitude;
    dynamic decodedJsonObject = await getData();
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: decodedJsonObject,
        );
      }));
    });
  }

  Future<dynamic> getData() async {
    // print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    print("a=$a");
    print("b=$b");
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$a&lon=$b&appid=9aaf8a49c64aa2aaf7f84b032eed6d9f&units=metric'));

    // print(response.body);
    // print(a);
    // print(b);
    // print("daddadiaaaaaaaaaaaaaaaaaaaaaa");
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
