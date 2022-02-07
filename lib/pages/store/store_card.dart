import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/store_model.dart';

class StoreCard extends StatelessWidget {
  // StoreCard({Key? key}) : super(key: key);
  late final StoreModel storeModel;
  StoreCard(this.storeModel);
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return GestureDetector(
      onTap: () {
        if (deviceType == DeviceType.WEB) {}
        Navigator.pushNamed(context, "/store", arguments: storeModel);
      },
      child: Container(
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(storeModel.image,
                  height: 130, fit: BoxFit.fitHeight),
              SizedBox(height: 5),
              Text(
                storeModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: textDarkColor),
              ),
              SizedBox(height: 5),
              Text(storeModel.address,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: textLightColor)),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[400],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(storeModel.review.toString())
                ],
              )
            ],
          )),
    );
  }
}
