import 'package:flutter/cupertino.dart';

class FavoriteModel with ChangeNotifier{
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  FavoriteModel({this.id, this.title, this.imageUrl, this.price, this.quantity});
}