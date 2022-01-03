import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/models/place.dart';
import 'package:food_app/pages/location/address_search.dart';
import 'package:food_app/widgets/back_button.dart';
import 'package:food_app/widgets/my_appBar.dart';
import 'package:uuid/uuid.dart';

class Location extends StatefulWidget {
  Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: MyAppBar(
          title: 'my_address',
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: TextField(
                controller: _controller,
                onTap: () async {
                  final sessionToken = Uuid().v4();
                  final Suggestion? result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      _controller.text = result.description;
                      _streetNumber = placeDetails.streetNumber!;
                      _street = placeDetails.street!;
                      _city = placeDetails.city!;
                      _zipCode = placeDetails.zipCode!;
                    });
                  }
                },
                // with some styling
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 20,
                    height: 10,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Enter your shipping address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                ),
              ),
            )
          ],
        ));
  }
}
