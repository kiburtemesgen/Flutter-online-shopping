import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/models/cart_model.dart';
import 'package:flutter_online_shop_app/providers/cart_provider.dart';
import 'package:flutter_online_shop_app/widgets/cart_widget.dart';
import 'package:flutter_online_shop_app/widgets/empty_cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_online_shop_app/providers/order_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty?  EmptyCart(): Scaffold(
        bottomSheet: checkoutSection(context, cartProvider.totalAmount, cartProvider.getCartItems.values.toList(), ),
        appBar: AppBar(
          title: Text('${cartProvider.getCartItems.length} Items'),
          actions: [
            IconButton(
              iconSize: 40,
              icon: Icon(Icons.restore_from_trash),
              onPressed: (){
                cartProvider.clrearCart();
              },)
          ],),
        body: ListView.builder(
          itemCount: cartProvider.getCartItems.length,
          itemBuilder: (BuildContext ctx, index){
            return ChangeNotifierProvider.value(
              value: cartProvider.getCartItems.values.toList()[index],
              child: CartWidget(
                productId: cartProvider.getCartItems.keys.toList()[index],

              ),
            );

          },
        ));
  }

  Widget checkoutSection(BuildContext ctx, double total, List<CartModel> cartProducts){
    final orderProvider = Provider.of<OrderProvider>(ctx);

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(ctx).size.width*0.6,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(55, 110, 176, 1).withOpacity(1),
                child: InkWell(
                  onTap: (){
                    orderProvider.addOrder(cartProducts, total);
                  },
                  child: Center(
                    child: Text('Checkout', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),),
                  ),
                ),
              ),
            ),
            Text('Total: $total', style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 18

            ),),
          ],),
      ),
    );
  }

}