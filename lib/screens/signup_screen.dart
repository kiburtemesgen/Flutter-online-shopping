import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_online_shop_app/screens/bottom_navigation_bar.dart';
import 'package:flutter_online_shop_app/screens/login_screen.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();
File _pickedImage;

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  void submit() async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));

      print(error);
    }
    final ref = FirebaseStorage.instance.ref().child('userImage').child(userName.text + '.jpg');
    await ref.putFile(_pickedImage);
    String url = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
      "UserName": userName.text,
      "UserId": result.user.uid,
      "UserEmail": email.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "UserUrl": url
    });
    Navigator.of(context).pushReplacementNamed(BottomNavigation.routeName);
    setState(() {
      isLoading = false;
    });
  }

  void vaildation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (email.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else if (address.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Adress Is Empty "),
        ),
      );
    } else {
      submit();
    }
  }

  Future<void> _pickCameraImage(BuildContext context) async {
    XFile picker = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    File file = File(picker.path);

    setState(() {
      _pickedImage = file;
    });

  }
  Future<void> _pickGalleryImage(BuildContext context) async {
    XFile picker = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    File file = File(picker.path);

    setState(() {
      _pickedImage = file;
    });

  }


  Widget _buildAllTextFormField() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            TextFormField(
              controller: userName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "User Name"),
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: password,
              obscureText: obserText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "password",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isMale = !isMale;
                });
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        isMale == true ? "Male" : "Female",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: phoneNumber,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Phone Number"),
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: address,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Address"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildAllTextFormField(),
            SizedBox(
              height: 10,
            ),
            isLoading == false
                ? Container(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      color:  Color.fromRGBO(55, 150, 176, 1).withOpacity(1),
                      onPressed: vaildation,
                      child: Text('Signup', style: TextStyle(color: Colors.white),),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            SizedBox(
              height: 5,
            ),
            Text('I Have Already an Account'),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
              ),

            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(55, 150, 176, 1).withOpacity(0.3),
              Color.fromRGBO(0, 0, 0, 1).withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _pickedImage == null
                          ? AssetImage('assets/images/userImage.png')
                          : FileImage(
                              _pickedImage
                            ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 80,
                    child: RawMaterialButton(
                      onPressed: () {
                        _pickCameraImage(context);
                        _pickGalleryImage(context);
                      },
                      elevation: 10,
                      fillColor: Colors.lightBlue,
                      child: Icon(Icons.add_a_photo),
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(

              child: _buildBottomPart(),
            ),
          ],
        ),
      ),
    );
  }
}
