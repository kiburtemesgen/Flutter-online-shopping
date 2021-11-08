import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop_app/models/cart_model.dart';

class CartProvider with ChangeNotifier{
  Map<String, CartModel> _cartItem = {};

  Map <String, CartModel> get getCartItems{
    return {..._cartItem};
  }

  double get totalAmount{
    var total = 0.0;
    _cartItem.forEach((key, value) {
      total+= value.price* value.quantity;
    });
    return total;
  }
  void addCart(String productId, double price, String title, String imageUrl){
    if(_cartItem.containsKey(productId)){
      _cartItem.update(productId, (existingCartItem) => CartModel(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity+1,
          imageUrl: existingCartItem.imageUrl
      ));
    }
    else{
      _cartItem.putIfAbsent(productId, () =>
          CartModel(
              id:DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imageUrl: imageUrl
          ));
    }
    notifyListeners();
  }
  void cartMinusOne(String productId, double price, String title, String imageUrl){

    if(_cartItem.containsKey(productId)) {
      _cartItem.update(productId, (existingCartItem) =>
          CartModel(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              imageUrl: existingCartItem.imageUrl
          ));
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _cartItem.remove(productId);
    notifyListeners();
  }
  void clrearCart(){
    _cartItem.clear();
    notifyListeners();
  }


}