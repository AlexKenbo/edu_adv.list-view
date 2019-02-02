import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../scoped-models/products.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  Widget _buildAddressPriceRow(double price) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Krasnodarskii krai, Anapa',
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
      child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
        final Product product = model.products[productIndex];   
        return Scaffold(
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
                    Image.asset(product.image),
                    TitleDefault(product.title),
                    _buildAddressPriceRow(product.price),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          product.description,
                          textAlign: TextAlign.left,
                        )),
                  ],
                )));
      }),
    );
  }
}
