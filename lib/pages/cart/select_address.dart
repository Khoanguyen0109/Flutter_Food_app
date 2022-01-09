import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/labelbox.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  Completer<GoogleMapController> _controller = Completer();
  String? _mapStyle;

  static final CameraPosition _currentLatLng = CameraPosition(
    target: LatLng(49.274789, -123.125889),
    zoom: 17,
  );

  Map<MarkerId, Marker> _markersList = <MarkerId, Marker>{};
  final MarkerId _pickUpMarkerId = MarkerId("pickup");

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor),
          leading: Center(
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsetsDirectional.only(start: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                  ),
                  child: Icon(Icons.navigate_before, color: Colors.black),
                  onPressed: () => Navigator.pop(context)),
            ),
          ),
          title: Text(
              AppLocalizations.of(context)!.translate('delivery_address')!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(BORDER_RADIUS),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _currentLatLng,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          zoomControlsEnabled: false,
                          markers: Set<Marker>.of(_markersList.values),
                          onMapCreated: (GoogleMapController controller) {
                            controller.setMapStyle(_mapStyle);
                            _controller.complete(controller);
                            updateMarker();
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Container(
                            width: 40,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: FloatingActionButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              elevation: 12,
                              backgroundColor: primaryColor,
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 20),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    AppLocalizations.of(context)!
                        .translate('delivery_details')!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textDarkColor)),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    hintText:
                        AppLocalizations.of(context)!.translate("address_hint"),
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textLightColor),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS)),
                  ),
                  minLines: 3,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textDarkColor),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    hintText:
                        AppLocalizations.of(context)!.translate("label_hint"),
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textLightColor),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS)),
                  ),
                  minLines: 2,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textDarkColor),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.translate('label_as')!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textDarkColor)),
                SizedBox(height: 10),
                LabelBox(),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: (deviceType == DeviceType.WEB) ? 20 : 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                      )),
                      elevation: MaterialStateProperty.all(12),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  child: Text(
                      AppLocalizations.of(context)!.translate('btn_save')!,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  updateMarker() async {
    MarkerId markerId = _pickUpMarkerId;
    _markersList[markerId] = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/images/image_marker.png", 64)),
      position: LatLng(49.274789, -123.125889),
      infoWindow: InfoWindow(
          title: AppLocalizations.of(context)!.translate('delivery_address')),
    );

    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
