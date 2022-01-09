import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<String> cuisineList = [
    'American',
    'Asian',
    'Beverage',
    'Cakes & Bakery',
    'Chinese',
    'Desserts',
    'Fast Food',
    'Healthy',
    'Italian',
    'Mexican',
    'Thai',
    'Vegetarian'
  ];

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return new Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading:
              (deviceType == DeviceType.WEB) ? false : true,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.translate('filter')!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textDarkColor)),
          iconTheme: IconThemeData(color: textDarkColor),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        AppLocalizations.of(context)!.translate('price_range')!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor)),
                    SizedBox(height: 10),
                    PriceRangeFilter(),
                    SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.translate('price')!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor)),
                    SizedBox(height: 10),
                    PriceFilter(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .translate('cuisines')!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor)),
                        Text(
                            AppLocalizations.of(context)!
                                .translate('btn_select_all')!,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: textMidColor)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: CuisineFilter(cuisineList),
                    )
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), blurRadius: 24)
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: (deviceType == DeviceType.WEB)
                                        ? 20
                                        : 15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              side: BorderSide(
                                  color: primaryColor,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: primaryColor))),
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('btn_clear')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: (deviceType == DeviceType.WEB)
                                        ? 20
                                        : 15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS),
                            )),
                            elevation: MaterialStateProperty.all(12),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white))),
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('btn_apply')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}

class PriceRangeFilter extends StatefulWidget {
  @override
  _PriceRangeFilterState createState() => _PriceRangeFilterState();
}

class _PriceRangeFilterState extends State<PriceRangeFilter> {
  static const min = 50.0;
  static const max = 1000.0;
  double low = min;
  double high = max;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$CURRENCY$min",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textDarkColor)),
            Text("$CURRENCY$max",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textDarkColor)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
          ),
          child: RangeSlider(
            min: min,
            max: max,
            activeColor: primaryColor,
            divisions: 100,
            values: RangeValues(low, high),
            labels: RangeLabels(low.toString(), high.toString()),
            onChanged: (values) => setState(() {
              low = values.start;
              high = values.end;
            }),
          ),
        ),
      ],
    );
  }
}

class PriceFilter extends StatefulWidget {
  @override
  _PriceFilterState createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  int selectedSize = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        priceBox(0, '$CURRENCY'),
        priceBox(1, '$CURRENCY$CURRENCY'),
        priceBox(2, '$CURRENCY$CURRENCY$CURRENCY'),
        priceBox(3, '$CURRENCY$CURRENCY$CURRENCY$CURRENCY'),
      ],
    );
  }

  Widget priceBox(int index, String title) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: Card(
            color: (selectedSize == index) ? primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: (selectedSize == index) ? 4 : 1,
            child: InkWell(
              onTap: () {
                setState(() => selectedSize = index);
              },
              child: Center(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: (selectedSize == index)
                            ? Colors.white
                            : textMidColor)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CuisineFilter extends StatefulWidget {
  final List<String> cuisinesList;
  CuisineFilter(this.cuisinesList);
  @override
  _CuisineFilterState createState() => _CuisineFilterState();
}

class _CuisineFilterState extends State<CuisineFilter> {
  String selectedBrand = 'Beverage';
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: widget.cuisinesList.length,
        itemBuilder: (context, index) {
          return listItem(widget.cuisinesList[index]);
        },
        separatorBuilder: (context, index) {
          return separator();
        },
      ),
    );
  }

  Widget listItem(String title) {
    return InkWell(
      onTap: () {
        setState(() => selectedBrand = title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: (selectedBrand == title)
                        ? primaryColor
                        : textMidColor)),
            if (selectedBrand == title) ...[
              Icon(Icons.check, color: primaryColor, size: 22)
            ]
          ],
        ),
      ),
    );
  }

  Widget separator() {
    return Divider(height: 1, thickness: 1, color: lineColor);
  }
}
