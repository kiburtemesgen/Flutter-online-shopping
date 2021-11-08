import 'package:flutter/material.dart';
import 'package:flutter_online_shop_app/consts/colors.dart';
import 'package:provider/provider.dart';
import '../models/favorite_model.dart';
import '../providers/favorite_provider.dart';

class FavoriteWidget extends StatefulWidget {
  final String productId;
  FavoriteWidget({this.productId});
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    void clearFav(){
      favoriteProvider.removeFavoriteItem(widget.productId);
    }

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color:   Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favoriteModel.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favoriteModel.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${favoriteModel.price.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(context, clearFav),
      ],
    );
  }

  Widget positionedRemove(BuildContext ctx, Function clear ) {
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(0.0),
            color: ColorsConsts.favColor,
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed:clear
        ),
      ),
    );
  }
}
