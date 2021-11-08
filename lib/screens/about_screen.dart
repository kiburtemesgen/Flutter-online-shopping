import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  static const routeName = '/about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(25),
              child: Text('About Developer', style: TextStyle(
                fontSize: 18
              ),),
            ),
            SizedBox(height: 50,),
            Text(
              'Kibur Temesgen',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Text('Email: kiburezelast@gmail.com'),
            InkWell(
              child: Text('Linkedin'),
              onTap: () async {
                const String linkedInUrl =
                    "https://www.linkedin.com/in/kibur-temesgen-9a2ba41bb/";
                if(await canLaunch(linkedInUrl)){
                  await launch(linkedInUrl);
                }
                else{
                  throw 'Could not launch url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
