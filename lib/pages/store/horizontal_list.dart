import 'package:flutter/material.dart';

import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/pages/store/store_card.dart';

class HorizontalScrollList extends StatefulWidget {
  // HorizontalScrollList({Key? key}) : super(key: key);
  late final String title;

  late final String routeName;

  late final List<dynamic> list;

  HorizontalScrollList({
    Key? key,
    required this.title,
    required this.routeName,
    required this.list,
  }) : super(key: key);
  @override
  State<HorizontalScrollList> createState() => _HorizontalScrollListState();
}

class _HorizontalScrollListState extends State<HorizontalScrollList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    print(widget.list.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
              start: (deviceType != DeviceType.WEB) ? 20 : 30,
              end: (deviceType != DeviceType.WEB) ? 10 : 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("popular_choices")!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: primaryColor),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, widget.routeName);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20))),
                child: Text(
                    AppLocalizations.of(context)!.translate("btn_show_all")!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textMidColor)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: (deviceType != DeviceType.WEB) ? 15 : 30),
                  itemBuilder: (context, index) {
                    // return item(widget.list[index], deviceType);
                    return StoreCard(widget.list[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.list.length),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                    width: 30,
                    margin:
                        EdgeInsets.all((deviceType != DeviceType.WEB) ? 5 : 30),
                    child: FloatingActionButton(
                      heroTag: "scroll_next_store",
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 2.0,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.navigate_next,
                          color: Colors.white, size: 20),
                      onPressed: () {
                        _scrollController.animateTo(
                            _scrollController.offset + 180,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
