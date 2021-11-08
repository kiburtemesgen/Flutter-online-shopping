import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop_app/models/cart_model.dart';

class OrderModel with ChangeNotifier{
  final String id;
  final double amount;
  final List<CartModel> products;
  final DateTime dateTime;

  OrderModel({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}