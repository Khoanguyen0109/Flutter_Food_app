import 'package:flutter/material.dart';

import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/utils.dart';
import 'package:food_app/widgets/circular_progress_bar.dart';

class PrepareOrder extends StatelessWidget {
  final int status;
  const PrepareOrder({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(status);
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            child: Image.asset("assets/images/image_order_tracking.jpg",
                fit: BoxFit.fitWidth),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          SafeArea(
            child: Center(
                child: CircularProgressBar(
                    currentProgress: ((status + 1) / 5) * 100)),
          ),
          SafeArea(
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Utils.renderStatus(status),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: Colors.white)),
                SizedBox(height: 5),
                Visibility(
                  visible: status != OrderStatus.REVICED &&
                      status != OrderStatus.DELIVERD,
                  child: Text("Food is comming",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ],
            )),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: SafeArea(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30),
          //         Text("ORDER IS PREPARING",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 fontSize: 22,
          //                 fontWeight: FontWeight.w600,
          //                 letterSpacing: 0.5,
          //                 color: Colors.white)),
          //         SizedBox(height: 5),
          //         Text(
          //             AppLocalizations.of(context)!
          //                 .translate('current_status')!,
          //             textAlign: TextAlign.center,
          //             style: TextStyle(fontSize: 14, color: Colors.white)),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
