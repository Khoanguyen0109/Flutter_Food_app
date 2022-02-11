import 'package:flutter/material.dart';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/order/widgets/order_row.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/services/order_services.dart';
import 'package:food_app/utils/constants.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  int? status;
  OrderList([this.status]);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  ScrollController _scrollController = new ScrollController();

  late List<OrderModel> _orders = [
    // OrderModel(
    //     id: 1,
    //     storeModel: StoreModel(
    //         id: '1',
    //         name: "Papaxot",
    //         image: 'assets/images/temp_item4.png',
    //         description: "156 Nguyen thi thap  ",
    //         address: "156 Nguyen thi thap  ",
    //         category: 0,
    //         review: 5.0),
    //     deliveryAddress: "422 nguyen thi thap",
    //     orderItems: [
    //       new OrderItem(
    //         quantity: 3,
    //         item: ItemModel(
    //             id: 1,
    //             name: 'Meat Ball Pasta',
    //             description: 'Spicy Meat Ball Pasta',
    //             image:
    //                 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fnature%2F&psig=AOvVaw1Th9JwtMAjJoQuDRplgOzx&ust=1644476239803000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOjs48KF8vUCFQAAAAAdAAAAABAD',
    //             reviews: 25,
    //             price: 3.5,
    //             status: 1,
    //             storeId: 1,
    //             choicesList: null),
    //       )
    //     ],
    //     delyveryCost: 2,
    //     itemCost: 122,
    //     total: 133,
    //     paymentMethod: 0,
    //     status: OrderStatus.DELIVERING,
    //     createdAt: DateTime.now())
  ];

  getOrderList() async {
    try {
      print(widget.status);
      List<OrderModel> orders = await OrderServices.fetchOrderList();
      setState(() {
        _orders = orders;
      });
    } catch (e) {
      print(e);
    }
  }

  getPreparingOrderListShipper() async {
    try {
      print(widget.status);
      List<OrderModel>? orders =
          await OrderServices.fetchOrderPreparingList(widget.status);
      if (orders != null) {
        setState(() {
          _orders = orders;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      User user = Provider.of<AuthProvider>(context, listen: false).getUser;
      String? role = user.role;
      print(role);
      if (role == 'shipper') {
        getPreparingOrderListShipper();
      } else {
        getOrderList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Container(),
    // )
    return SafeArea(
      // child: SingleChildScrollView(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: _orders.length,
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   height: 100,
            // );
            return OrderRow(orderModel: _orders[index]);
          }
          // ),
          ),
    );
  }
}
