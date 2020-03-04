import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'd663a2eaa30c80d328a3f6948e716b0c';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();

    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    //NetworkHelper networkHelper = NetworkHelper(
        //'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$latitude&lon=$longitude&cnt=10&appid=$apiKey');


    NetworkHelper networkHelper = NetworkHelper(
    'https://api.openweathermap.org/data/2.5/forecast/daily?lat=34&lon=139&cnt=10&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

//{"coord":{"lon":-122.09,"lat":37.39},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"base":"stations","main":{"temp":280.44,"pressure":1017,"humidity":61,"temp_min":279.15,"temp_max":281.15},"visibility":12874,"wind":{"speed":8.2,"deg":340,"gust":11.3},"clouds":{"all":1},"dt":1519061700,"sys":{"type":1,"id":392,"message":0.0027,"country":"US","sunrise":1519051894,"sunset":1519091585},"id":0,"name":"Mountain View","cod":200}
