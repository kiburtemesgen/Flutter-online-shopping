import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop_app/models/cart_model.dart';
import 'package:flutter_online_shop_app/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];


  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartModel> cartProducts, double total){
    _orders.insert(0, OrderModel(
      id: DateTime.now().toString(),
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts
    ));
  }

}