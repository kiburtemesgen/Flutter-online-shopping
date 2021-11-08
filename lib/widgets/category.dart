import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/providers/products.dart';
import 'package:flutter_online_shop_app/screens/all_products.dart';
import 'package:flutter_online_shop_app/widgets/all_product_widget.dart';
import 'package:flutter_online_shop_app/widgets/category_widget.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Category extends StatefulWidget with ChangeNotifier {
  static const routeName = '/category';

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<Map<String, dynamic>> categories = [
    {'iconName': 'Laptop', 'Icon': 'assets/images/laptop.png'},
    {'iconName': 'Phone', 'Icon': 'assets/images/phone.jpg'},
    {'iconName': 'Shoes', 'Icon': 'assets/images/shoes.png'},
    {'iconName': 'Cloth', 'Icon': 'assets/images/cloth.png'},
    {'iconName': 'Electronics', 'Icon': 'assets/images/electronics.png'},
  ];
  TextEditingController _searchTextController;
  final FocusNode _focusNode = FocusNode();

  void initState() {

    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _searchTextController.dispose();
  }

  String catname ='';
  String searchName ='';

  String catButton(String name) {
    setState(() {
      catname = name;
      searchName ='';

    });
  }



  @override
  Widget build(BuildContext context) {

    final categoryName = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<Products>(context);
    String catName = 'shoes';
    final searchBy = Provider.of<Products>(context).searchQuery(searchName);

    final prod = products.findByCategory(catname);
    //List<Product> productsList = prod;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _searchTextController,
            focusNode: _focusNode,
            onChanged: (value) {
              _searchTextController.text.toLowerCase();
              setState(() {
                searchName = value;

              });
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search product",
              filled: true,
              fillColor: Theme.of(context).cardColor,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: _searchTextController.text.isEmpty
                    ? null
                    : () {
                        _searchTextController.clear();
                        _focusNode.unfocus();

                        },
                icon: Icon(Icons.cancel,
                    color: _searchTextController.text.isNotEmpty
                        ? Colors.red
                        : Colors.grey),
              ),
            ),
          ),
        ),
        Divider(),
        Container(
         height: 70,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctx, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF2F3F7)),
                            child: RawMaterialButton(
                                onPressed: () {

                                  print(categories[index]['iconName']);
                                  catButton(categories[index]['iconName']);
                                  // Navigator.of(context).pushNamed(Category.routeName,
                                  //     arguments: '${categories[widget.index]['iconName']}');
                                },
                                shape: CircleBorder(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage(categories[index]['Icon']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                          ),
                          Text(
                            categories[index]['iconName'],
                            style: TextStyle(
                                color: Color.fromRGBO(55, 100, 176, 1).withOpacity(1),
                                fontFamily: 'Roboto-Light.ttf',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
        Divider(),
        Container(

          height: 380,
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 250 / 240,
            children: List.generate(
                searchName == '' ? prod.length : searchBy.length,
                 (index) {
              return ChangeNotifierProvider.value(
                value:
                searchName == '' ? prod[index] : searchBy[index],
                child: AllProductsWidget(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
