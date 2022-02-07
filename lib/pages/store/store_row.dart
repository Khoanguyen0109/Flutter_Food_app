import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/store_model.dart';

class StoreRow extends StatelessWidget {
  final StoreModel storeModel;
  // const StoreRow({
  //   required this.storeModel,
  // }) : super(key: key);
  StoreRow(this.storeModel);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/store", arguments: storeModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 115,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 15, top: 15),
                      child: Image.network(storeModel.image,
                          width: 100, height: 100, fit: BoxFit.fitHeight),
                    ),
                  ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(storeModel.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textDarkColor)),
                    Text(storeModel.description,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: textLightColor)),
                    SizedBox(height: 5),
                    Text(storeModel.address,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: textLightColor)),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/icon_star.png",
                                  width: 18, height: 18),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text(storeModel.review.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: textDarkColor))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
