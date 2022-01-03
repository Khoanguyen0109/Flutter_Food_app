import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:food_app/pages/order/widgets/order_map.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/dotted_line.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTracking2 extends StatefulWidget {
  @override
  _OrderTracking2State createState() => _OrderTracking2State();
}

class _OrderTracking2State extends State<OrderTracking2> {
  Completer<GoogleMapController> _controller = Completer();
  String? _mapStyle;

  static final CameraPosition _currentLatLng = CameraPosition(
    target: LatLng(49.274789, -123.125889),
    zoom: 17,
  );

  Map<MarkerId, Marker> _markersList = <MarkerId, Marker>{};
  final MarkerId _riderMarkerId = MarkerId("rider");

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
        body: Stack(
          children: [
            Scrollbar(
              isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    OrderMap(
                        currentLatLng: _currentLatLng,
                        markersList: _markersList),
                    Container(height: 10, color: lineColor),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(Icons.keyboard_arrow_up,
                              color: textMidColor, size: 30),
                          Text("ORDER IS PREPARING",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: primaryColor)),
                          SizedBox(height: 5),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('current_status')!,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: textMidColor)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('order_details')!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textDarkColor)),
                          SizedBox(height: 10),
                          buildDetailRow(
                              AppLocalizations.of(context)!
                                  .translate('your_order_number')!,
                              "#208"),
                          SizedBox(height: 5),
                          buildDetailRow(
                              AppLocalizations.of(context)!
                                  .translate('delivery_address')!,
                              "Vancouver, BC V6C 2T4"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          buildDetailRow('2x Meat Ball Pasta', "${CURRENCY}35"),
                          SizedBox(height: 5),
                          buildDetailRow('1x Steak', "${CURRENCY}20"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          buildDetailRow(
                              AppLocalizations.of(context)!
                                  .translate('sub_total')!,
                              "${CURRENCY}90"),
                          SizedBox(height: 5),
                          buildDetailRow(
                              "$TAX_LABEL ($TAX_PERCENTAGE%)", "${CURRENCY}17"),
                          SizedBox(height: 5),
                          buildDetailRow(
                              AppLocalizations.of(context)!
                                  .translate('delivery_cost')!,
                              AppLocalizations.of(context)!.translate('free')!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  AppLocalizations.of(context)!
                                      .translate('total_inclusive_tax')!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor)),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text("${CURRENCY}107",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: textDarkColor)),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          buildDetailRow(
                              AppLocalizations.of(context)!
                                  .translate('payment_method')!,
                              AppLocalizations.of(context)!
                                  .translate('cash_on_delivery')!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: DottedLine(dashWidth: 5, color: lineColor),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5), blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
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
            ),
          ],
        ));
  }

  updateMarker() async {
    MarkerId markerId = _riderMarkerId;
    _markersList[markerId] = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/images/image_marker_rider.png", 64)),
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

  buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textMidColor)),
        SizedBox(width: 10),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
        ),
      ],
    );
  }
}
