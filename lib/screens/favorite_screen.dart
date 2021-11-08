import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/widgets/empty-favorite.dart';
import 'package:flutter_online_shop_app/widgets/favorite_widget.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/Favorite-Screen';


  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return favoriteProvider.favoriteItems.isEmpty?  EmptyFavorite(): Scaffold(

      body: ListView.builder(
          itemCount: favoriteProvider.favoriteItems.length,
          itemBuilder: (BuildContext ctx, int index){
            return ChangeNotifierProvider.value(
                value: favoriteProvider.favoriteItems.values.toList()[index],
                child: FavoriteWidget(productId: favoriteProvider.favoriteItems.keys.toList()[index],));
          }),

    );
  }


}