import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/screens/about_screen.dart';
import 'package:flutter_online_shop_app/screens/bottom_navigation_bar.dart';
import 'package:flutter_online_shop_app/screens/login_screen.dart';
import 'package:flutter_online_shop_app/screens/manage_product.dart';
import 'package:flutter_online_shop_app/screens/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final usrcall = Provider.of<Products>(context).getUserData();
    UserModel usr = Provider.of<Products>(context).userModel;


    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AppBar(
              title: Text('Options'),
              automaticallyImplyLeading: false,
            ),
            UserAccountsDrawerHeader(
                accountName: Text(usr == null ? 'no' : usr.userName),
                accountEmail: Text(usr == null ? 'no' : usr.userEmail),
                currentAccountPicture: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: usr.userImage == null
                          ? AssetImage('assets/images/userImage.png')
                          : NetworkImage(usr.userImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushNamed(BottomNavigation.routeName);
                //Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Prodcuts'),
              onTap: () {
                Navigator.of(context).pushNamed(ManageProduct.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About developer'),
              onTap: () {
                Navigator.of(context).pushNamed(About.routeName);
                // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                //Navigator.of(context).pushNamed(Login.routeName);
                // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
