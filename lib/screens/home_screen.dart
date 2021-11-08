import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/consts/colors.dart';
import 'package:flutter_online_shop_app/providers/cart_provider.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/screens/cart_screen.dart';
import 'package:flutter_online_shop_app/screens/favorite_screen.dart';
import 'package:flutter_online_shop_app/widgets/all_product_widget.dart';
import 'package:flutter_online_shop_app/widgets/category.dart';
import 'package:flutter_online_shop_app/widgets/category_widget.dart';
import 'package:flutter_online_shop_app/widgets/drawer_widget.dart';
import 'package:flutter_online_shop_app/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

Products products;

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {


   final productsProvider = Provider.of<Products>(context, listen: false).fetchProducts();

    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Online Shop'),
          flexibleSpace: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [
            Color.fromRGBO(55, 150, 176, 1).withOpacity(0.8),
            Color.fromRGBO(0, 0, 0, 1).withOpacity(0.35),
          ],
          begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
    ),
    ),

      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed(FavoriteScreen.routeName);
        }, icon: Icon(Icons.favorite)),
        Badge(
          position: BadgePosition.topEnd(top: 4, end: 4),
          animationType: BadgeAnimationType.slide,
          toAnimate: true,
          badgeContent: Text(cartProvider.getCartItems.length.toString(), style: TextStyle(color: Colors.white),),

          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
      ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children:[
            SizedBox(height: 5,),
            SizedBox(height: 20,),
            Category(),

],
      ),
      ),
    );
  }

}
