//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/consts/colors.dart';
import 'package:flutter_online_shop_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';


class CartWidget extends StatefulWidget {

  final String productId;

  CartWidget({this.productId});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double total = cartModel.price*cartModel.quantity;



    return Container(
      height: 140,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(16),
              topRight: const Radius.circular(16)
          ),
          color: Colors.blueGrey.withOpacity(0.2)
      ),

      child: Row(children: [
        Container(
          width: 120,
          decoration: BoxDecoration(image: DecorationImage(
              image: NetworkImage(cartModel.imageUrl),
              fit: BoxFit.fill
          )),
        ),
        Flexible(
          child: InkWell(
            onTap: (){
              // Navigator.of(context).pushNamed(ProductDetails.routeName,
              //     arguments: widget.productId
              //);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(cartModel.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),)),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        //splashColor: ,
                        onTap: (){
                          cartProvider.removeItem(widget.productId);
                        },
                        child: Container(
                          height: 50, width: 50,
                          child: Icon(Icons.delete),),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Price'),
                    SizedBox(width: 5,),
                    Text('\$ ${cartModel.price.toString()}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ],
                ),
                Row(
                  children: [
                    Text('subtotal'),
                    SizedBox(width: 5,),
                    Text('\$ ${total.toString()}', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,

                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text('Ships Free', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:  Theme.of(context).accentColor,

                    ),),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        //splashColor: ,
                        onTap: cartModel.quantity<=1? (){}:(){
                          cartProvider.cartMinusOne(widget.productId, cartModel.price, cartModel.title, cartModel.imageUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.remove_circle),),
                      ),
                    ),
                    Card(

                      elevation: 12,
                      child: Container(width: MediaQuery.of(context).size.width*0.15,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [
                          Color.fromRGBO(55, 150, 176, 1).withOpacity(0.8),
                          Color.fromRGBO(0, 0, 0, 1).withOpacity(0.2),
                        ],
                            stops: [0.0, 0.7]
                        )),
                        child: Text(cartModel.quantity.toString(), textAlign: TextAlign.center,),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        //splashColor: ,
                        onTap: (){
                          cartProvider.addCart(widget.productId, cartModel.price, cartModel.title, cartModel.imageUrl);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.add_circle),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],),
    );
  }
}
