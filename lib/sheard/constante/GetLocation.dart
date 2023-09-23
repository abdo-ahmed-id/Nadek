import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

 Future<List<Placemark>> PassLocation()async{
  await [Permission.location,Permission.locationAlways].request();
  Position position =await
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> address=await
  placemarkFromCoordinates(position.latitude, position.longitude);
  var firs =address.first;

  print(" "
      "country ${firs.country}"
      " :name ${firs.name} "
      ":locality ${firs.locality} "
      ":subLocality ${firs.subLocality}"
      ":administrativeArea ${firs.administrativeArea}"
      ":subAdministrativeArea ${firs.subAdministrativeArea}"
      ":thoroughfare ${firs.thoroughfare}"
      ":subThoroughfare${firs.subThoroughfare}"
      ":street${firs.street}"
      ":${firs.isoCountryCode}");
  return address;

}
