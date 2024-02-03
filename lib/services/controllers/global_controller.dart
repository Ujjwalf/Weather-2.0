import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalContorller extends GetxController {
  //all required variables
  final RxBool _isloading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  //instances for them to be called
  RxBool checkLoading() => _isloading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;
    //check if service is enabled
    if (!isServiceEnabled) {
      return Future.error("Location service is not enabled.");
    }

    //status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        return Future.error("Location permission denied forever.");
      }
    }

    //getting the current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update the latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isloading.value = false;
    });
  }
}
