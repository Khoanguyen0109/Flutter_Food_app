import 'package:flutter/material.dart';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/pages/order/widgets/order_row.dart';
import 'package:food_app/utils/constants.dart';

class OrderList extends StatefulWidget {
  int? status;
  OrderList([this.status]);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  ScrollController _scrollController = new ScrollController();

  late List<OrderModel> _orders = [
    OrderModel(
        id: 1,
        storeModel: StoreModel(
            id: 1,
            name: "Papaxot",
            image: 'assets/images/temp_item4.png',
            description: "156 Nguyen thi thap  ",
            address: "156 Nguyen thi thap  ",
            category: 0,
            review: 5.0),
        deliveryAddress: "422 nguyen thi thap",
        orderItems: [
          new OrderItem(
              quantity: 3,
              item: ItemModel(
                  id: 1,
                  name: 'Meat Ball Pasta',
                  description: 'Spicy Meat Ball Pasta',
                  image: 'assets/images/temp_item1.png',
                  reviews: 25,
                  price: 3.5,
                  status: 1,
                  storeId: 1,
                  choicesList: null),
              totalPrice: 122)
        ],
        delyveryCost: 2,
        itemCost: 122,
        total: 133,
        paymentMethod: 0,
        status: OrderStatus.DELIVERD)
  ];

  getOrderList() async {
    Future<List<OrderModel>> orders = await getOrderList();
    // setState(() {
    //   _orders = orders ;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: false,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            OrderRow(orderModel: _orders[0]),
            // OrderRow(orderModel,: _offersArray[1]),
          ],
        ),
      ),
    );
  }
}
