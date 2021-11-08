import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/widgets/all_product_widget.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class AllProducts extends StatelessWidget {
  static const routeName = '/feeds';



  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<Products>(context);
    List<Product> productsList = productsProvider.products;
    return Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 250/280,
          children: List.generate(productsList.length, (index) {
            return ChangeNotifierProvider.value(
              value: productsList[index],
              child: AllProductsWidget(),
            );
          }),

        )
    );
  }
}
