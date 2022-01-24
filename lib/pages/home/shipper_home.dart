import 'package:flutter/material.dart';
import 'package:food_app/pages/order/order_list.dart';
import 'package:food_app/utils/constants.dart';

class ShipperHome extends StatefulWidget {
  ShipperHome({Key? key}) : super(key: key);

  @override
  _ShipperHomeState createState() => _ShipperHomeState();
}

class _ShipperHomeState extends State<ShipperHome> {
  // late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.reorder)),
            ],
          ),
          title: Row(
            children: [
              Expanded(child: Text('Shipper Order')),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                      icon: Icon(Icons.notifications)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/my_account");
                      },
                      icon: Icon(Icons.person)),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          // controller: tabController,
          children: [
            OrderList(OrderStatus.PREPARING),
            OrderList(OrderStatus.DELIVERING),
            OrderList(OrderStatus.DELIVERD),
          ],
        ),
      ),
    );
  }
}
