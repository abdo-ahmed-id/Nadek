import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nadek/data/model/LocationUserModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:permission_handler/permission_handler.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  static double? latit;
  static double? long;
  bool isLoading = true;
  String? token;
  CameraPosition? _kLake;
  List<Marker> _markers = <Marker>[];
  Iterable markers = [];
  String? photo;



  LocationUserModel? model;


  Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    token =CacheHelper.getString('tokens');
    photo =CacheHelper.getString('photo');

    _getLocation();

  }


  Future<ui.Image> getImageFromPath(String imagePath) async {
    AssetImage assetImage = AssetImage(imagePath);
    File imageFile = File(assetImage.assetName);
    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }






  _getLocation() async {
    if (await Permission.location.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      print('openAppSettings');

      openAppSettings();

      Fluttertoast.showToast(
          msg: "اسمح لتطبيق الوصول الي الموقع",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);


    }else{
      await [Permission.location,Permission.locationWhenInUse].request();

      if (await Permission.location.isDenied) {
        openAppSettings();

        Fluttertoast.showToast(
          msg: "اسمح لتطبيق الوصول الي الموقع",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pop(context);
      }else{
        if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
          // Use location.
          var location =Location();
          LocationData locationData =await location.getLocation();
          setState((){
            latit=locationData.latitude!;
            long=locationData.longitude!;
            isLoading = false;

          });
          _markers.add(
              Marker(
                  icon: await MarkerIcon.downloadResizePictureCircle(
                    photo!,
                    size: 150,
                    addBorder: true,
                    borderColor: ColorApp.move,
                    borderSize: 10,
                  ),
                  markerId: MarkerId('Mi_Location'),
                  position: LatLng(
                    locationData.latitude!,
                    locationData.longitude!,
                  ),
                  infoWindow: InfoWindow(
                    title: 'موقعي',

                  )

              )
          );
          setState(() {
            _markers;
          });


        }
      }

    }




  }
  static final CameraPosition _kGooglePlex= CameraPosition(
    target: LatLng(latit!, long!),
    zoom: 7,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) async{
          if (state is LoadedGetAllocatonUser) {
            setState(() {
              model =state.data;

            });
            for(int i=0;i<state.data.data!.length;i++){

              double x = model!.data![i].lat as double;
              double y= model!.data![i].long as double;

              print(y);
              _markers.add(
                Marker(
                  markerId: MarkerId(model!.data![i].id.toString()),
                  infoWindow: InfoWindow(
                    title: model!.data![i].name,
                    onTap: (){
                      Navigator.pushNamed(
                          context,
                          '/ProfileOfUser',
                          arguments: [
                            model!.data![i].id!.toInt(),
                          ]

                      );
                    }
                  ),
                  position: LatLng(
                      x,
                      y

                  ),
                  icon: await MarkerIcon.downloadResizePictureCircle(
                    model!.data![i].photo!,
                  size: 150,
                  addBorder: true,
                  borderColor: ColorApp.move,
                  borderSize: 10,
                ),
              ),);
              setState(() {
                _markers;
              });
            }






          }

        },
        builder: (context, state) {
          return isLoading?
         const Center(
            child: CircularProgressIndicator(),
          )
         : GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set.from(_markers),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _completer.complete(controller);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorApp.blue,
        onPressed: _goToTheLake,
        label: Text('بحث'),
        icon: Icon(Icons.search_rounded,),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    BlocProvider.of<NadekCubit>(context).GetAllocationUser(token: token!);

  }


}
