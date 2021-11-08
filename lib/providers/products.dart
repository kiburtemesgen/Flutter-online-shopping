import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:flutter_online_shop_app/models/user_model.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  findById(String id){
    return _products.firstWhere((element) => element.id.toString()==id.toString());
  }
  List<Product> findByCategory (String categoryName){
    List _categoryList = _products.where((element) => element.productCategoryName.toLowerCase().contains(categoryName.toLowerCase())).toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) =>
        element.title.toLowerCase().contains(searchText==null?'':searchText.toLowerCase()))
        .toList();
    return _searchList;
  }

  void deleteProducts(String id) {

    _products.removeWhere((prod) => prod.id==id);
    notifyListeners();
  }

  List<UserModel> userModelList = [];
  UserModel userModel = UserModel(
    userAddress: 'Address',
    userImage: 'User Image',
    userEmail: 'Email',
    userGender: 'Gender',
    userName: 'User Name',
    userPhoneNumber: 'Phone Number',
  );



  Future<void> getUserData() async {


    List<UserModel> newList = [];
    User currentUser = await FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
    await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
          (element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        if (currentUser.uid == data["UserId"]) {
          userModel = UserModel(
              userAddress: data["UserAddress"],
              userImage: data["UserUrl"],
              userEmail: data["UserEmail"],
              userGender: data["UserGender"],
              userName: data["UserName"],
              userPhoneNumber: data["UserNumber"],

          );
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );

    notifyListeners();

  }


  CollectionReference fsProducts =  FirebaseFirestore.instance.collection('products');
  Future <void> addFsProducts(Product product){
    return fsProducts.add(
       { 'title': product.title,
        'description': product.description,
       ' price': product.price,
        'imageUrl': product.imageUrl,
        'id':product.title,
       ' productCategoryName':product.productCategoryName,
        'brand': product.brand,
        'isFeatured': false,
        'quantity': product.quantity}
    );

  }
  Product newProd = Product(
      title: 'title',
      description: 'description',
      price: 30,
      imageUrl: '',
      id: 'id',
      productCategoryName:'category',
      brand: 'brand',
      isFeatured: false,
      quantity: 1
  );


  Future <void> fetchProducts() async{
    List<Product> fetchList = [];

    QuerySnapshot prodSnapShot = await FirebaseFirestore.instance.collection('products').get();
    prodSnapShot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      newProd = Product(
          title: data["title"],
          description: data["description"],
          price: data[" price"],
          imageUrl: data["imageUrl"],
          id: data['id'],
          productCategoryName:data[' productCategoryName']==null? '': data[' productCategoryName'],
          brand: data['brand'],
          isFeatured: false,
          quantity: data['quantity']);
      print(newProd.description);
      fetchList.add(newProd);

    });
    _products = fetchList;

    notifyListeners();

  }



  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
      productCategoryName:'cloth',
      brand: 'no brand',
      isFeatured: false,
      quantity: 1
    );
    print(product.imageUrl);
    _products.add(newProduct);
    notifyListeners();
  }
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final newProd = Product(
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl,
          id: DateTime.now().toString(),
          productCategoryName:'cloth',
          brand: 'no brand',
          isFeatured: false,
          quantity: 1
      );
      _products[prodIndex] = newProd;
      notifyListeners();
    } else {
      print('...');
    }
  }


  






}

