import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Widget _buildAddressPriceRow(String address, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            address,
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey)),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '|',
              style: TextStyle(color: Colors.grey),
            )),
        Text(
          '\$' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print('Back button pressed');
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center, // выравнивание по вертикали. не используем тк с картинкой по центру не красиво
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // выравнивание по горизонтали не сработало, так как ширина столбца = ширине элемента
                  children: <Widget>[
                    FadeInImage(
                      image: NetworkImage(product.image),
                      height: 300.0,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/background.jpg'),
                    ),
                    
                    TitleDefault(product.title),
                    _buildAddressPriceRow(product.location.address ,product.price),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          product.description,
                          textAlign: TextAlign.left,
                        )),
                  ],
                ))));
  }
}
