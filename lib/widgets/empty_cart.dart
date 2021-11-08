import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/screens/bottom_navigation_bar.dart';
import 'package:flutter_online_shop_app/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.4,
            decoration: BoxDecoration(image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/empty-cart.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text('Your Cart Is Empty!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600),),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.height*0.5,
            child: RaisedButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(BottomNavigation.routeName);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.blue)),
              color: Colors.orange,
              child: Text('shop now'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w600
                ),

              ),


            ),
          )
        ],
      ),
    );
  }
}
