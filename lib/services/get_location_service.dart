import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<List<String>> getCityNameFromCurrentLocation() async {
    List<String> latitudeAndLongitude = [];
    //get the permission from the user to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();

    print(latitude);
    print(longitude);

    latitudeAndLongitude.add(latitude);
    latitudeAndLongitude.add(longitude);

    // //conver the location in to list of place marks
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);

    // //extract the city name from the place marks
    // String cityName = placemarks.isNotEmpty && placemarks[0].locality != null
    //     ? placemarks[0].locality!
    //     : 'Unknown Location';

    // print(cityName);

    return latitudeAndLongitude;
  }
}
