import 'package:coffeeshopui/core/constants/app_constants.dart';
import 'package:coffeeshopui/core/router/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  var _currentAddress='';


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
       context.go(RoutesNames.home);
      }
    });
    _determinePosition();
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // Handle permanently denied permission
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Location settings
    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    // Get position
    Position position =
    await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    double lat = position.latitude;
    double long = position.longitude;

    print("Latitude: $lat and Longitude: $long");

    // Get address from lat long
    await _getAddressFromLatLng(position);

    return position;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        print('current Address==>>>>  ${_currentAddress} ${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}');
      });
      print("Name: ${place.name}");
      print("Street: ${place.street}");
      print("Thoroughfare: ${place.thoroughfare}");
      print("SubLocality: ${place.subLocality}");
      print("Locality: ${place.locality}");
      print("SubAdministrativeArea: ${place.subAdministrativeArea}");
      print("PostalCode: ${place.postalCode}");

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Text(
            'C@ffeeVerse..',
            style: GoogleFonts.bebasNeue(fontSize: 42, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
