import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_online_shop_app/providers/cart_provider.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/screens/product_detail.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';

class AllProductsWidget extends StatefulWidget {

  @override
  _AllProductsWidgetState createState() => _AllProductsWidgetState();
}

class _AllProductsWidgetState extends State<AllProductsWidget> {



  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: product.id);
        //print('PT:${product.title}');
      },
      child: Container(
        // width: 50,
        //  height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.blueGrey.withOpacity(0.2)),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.grey,
                  height: 120,
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 120,
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                // top: 0,
                // left: 0,
                child: Badge(
                  alignment: Alignment.topLeft,
                  toAnimate: false,
                  //position: BadgePosition.bottomEnd(),
                  shape: BadgeShape.square,
                  badgeColor: Colors.deepPurple,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(8)),
                  badgeContent: product.isFeatured == true
                      ? Text(
                          'Featured',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      : Text('new', style: TextStyle(color: Colors.white)),
                ),
              ),
            ]),
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$ ${product.price}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.quantity.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            cartProvider.addCart(product.id, product.price,
                                product.title, product.imageUrl);
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
