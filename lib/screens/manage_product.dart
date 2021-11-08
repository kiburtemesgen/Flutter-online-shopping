import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/widgets/drawer_widget.dart';
import 'package:flutter_online_shop_app/widgets/manage_product_widget.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './edit_product_screen.dart';

class ManageProduct extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body:Consumer<Products>(
            builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.products.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    ManageProductWidget(
                      productsData.products[i].id,
                      productsData.products[i].title,
                      productsData.products[i].imageUrl,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
