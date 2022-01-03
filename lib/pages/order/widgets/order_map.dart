import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMap extends StatelessWidget {
  const OrderMap({
    Key? key,
    required CameraPosition currentLatLng,
    required Map<MarkerId, Marker> markersList,
  })  : _currentLatLng = currentLatLng,
        _markersList = markersList,
        super(key: key);

  final CameraPosition _currentLatLng;
  final Map<MarkerId, Marker> _markersList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _currentLatLng,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            markers: Set<Marker>.of(_markersList.values),
            onMapCreated: (GoogleMapController controller) {
              // controller.setMapStyle(_mapStyle);
              // _controller.complete(controller);
              // updateMarker();
            },
          ),
          Positioned.fill(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.5],
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
          // Positioned.fill(
          //   child: Container(color: Colors.black.withOpacity(0.5)),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("05 Minutes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 5),
                Text("45 Seconds",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
