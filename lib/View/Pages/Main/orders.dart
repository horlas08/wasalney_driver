import 'package:driver/View/Components/Pages/Home/orders-page.dart';
import 'package:flutter/material.dart';
class OrdersHistory extends StatelessWidget {
  const OrdersHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OrdersHistoryPage(),
      ),
    );
  }
}
