import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop_app/models/favorite_model.dart';


class FavoriteProvider with ChangeNotifier{
  Map<String, FavoriteModel> _favoriteItems = {};

  Map<String, FavoriteModel> get favoriteItems {
    return {..._favoriteItems};
  }


  void addFavorite(String productId, double price, String title, String imageUrl){
    if(_favoriteItems.containsKey(productId)){
      removeFavoriteItem(productId);
    }
    else{
      _favoriteItems.putIfAbsent(productId, () =>
          FavoriteModel(
              id:DateTime.now().toString(),
              title: title,
              price: price,
              imageUrl: imageUrl
          ));
    }
    notifyListeners();
  }

  void removeFavoriteItem(String productId){
    _favoriteItems.remove(productId);
    notifyListeners();
  }

}