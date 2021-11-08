import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier{
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartModel({this.id, this.title, this.imageUrl, this.price, this.quantity});
}