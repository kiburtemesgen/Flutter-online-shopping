import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/providers/order_provider.dart';
import 'package:flutter_online_shop_app/widgets/drawer_widget.dart';
import 'package:flutter_online_shop_app/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: orderData.orders[i],
            child: OrderWidget()),
      ),
    );
  }
}
