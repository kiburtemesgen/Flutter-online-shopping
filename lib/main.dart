import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/models/cart_model.dart';
import 'package:flutter_online_shop_app/models/favorite_model.dart';
import 'package:flutter_online_shop_app/providers/cart_provider.dart';
import 'package:flutter_online_shop_app/providers/favorite_provider.dart';
import 'package:flutter_online_shop_app/providers/order_provider.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/screens/about_screen.dart';
import 'package:flutter_online_shop_app/screens/bottom_navigation_bar.dart';
import 'package:flutter_online_shop_app/screens/cart_screen.dart';
import 'package:flutter_online_shop_app/screens/edit_product_screen.dart';
import 'package:flutter_online_shop_app/screens/favorite_screen.dart';
import 'package:flutter_online_shop_app/screens/login_screen.dart';
import 'package:flutter_online_shop_app/screens/manage_product.dart';
import 'package:flutter_online_shop_app/screens/order_screen.dart';
import 'package:flutter_online_shop_app/screens/product_detail.dart';
import 'package:flutter_online_shop_app/screens/signup_screen.dart';
import 'package:flutter_online_shop_app/widgets/all_product_widget.dart';
import 'package:flutter_online_shop_app/widgets/category.dart';
import 'package:flutter_online_shop_app/widgets/category_widget.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/order_model.dart';
import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value:  Product(),),
      ChangeNotifierProvider.value(value:  Products(),),
      ChangeNotifierProvider.value(value: BottomNavigation(),),
      ChangeNotifierProvider.value(value:  CartModel(),),
      ChangeNotifierProvider.value(value:  CartProvider(),),
      ChangeNotifierProvider.value(value:  FavoriteProvider(),),
      ChangeNotifierProvider.value(value:  FavoriteModel(),),
      ChangeNotifierProvider.value(value: OrderProvider(),),
      ChangeNotifierProvider.value(value: OrderModel(),),


    ],
    child: Consumer<BottomNavigation>(builder: (ctx, bottom,_) =>MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange
      ),
      home:  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigation();
          } else {
            return Login();
          }
        },
      ),
      routes: {
        ProductDetails.routeName:(ctx) => ProductDetails(),
        CartScreen.routeName: (ctx) => CartScreen(),
        FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
        Category.routeName: (ctx) => Category(),
        OrdersScreen.routeName: (ctx)=> OrdersScreen(),
        BottomNavigation.routeName:(ctx) => BottomNavigation(),
        About.routeName : (ctx) => About(),
        EditProductScreen.routeName : (ctx) => EditProductScreen(),
        ManageProduct.routeName : (ctx) => ManageProduct(),
        SignUp.routeName : (ctx) => SignUp(),
        Login.routeName : (ctx) => Login()
      },
    ),),
    );
  }
}


