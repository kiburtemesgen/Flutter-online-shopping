import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';



class ManageProductWidget extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  // final Function deleteHandler;

  ManageProductWidget(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    print(title);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(icon: Icon(Icons.edit), onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName,
                arguments: id
            );
          },),
          IconButton(icon: Icon(Icons.delete), onPressed: (){
            Provider.of<Products>(context, listen: false).deleteProducts(id);
          },),
        ],),
      ),

    );
  }
}
