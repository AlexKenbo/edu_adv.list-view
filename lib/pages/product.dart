import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final String description;

  ProductPage(this.title, this.image, this.price, this.description);

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
          title: Text(title),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column( 
            //mainAxisAlignment: MainAxisAlignment.center, // выравнивание по вертикали. не используем тк с картинкой по центру не красиво
            crossAxisAlignment: CrossAxisAlignment.center, // выравнивание по горизонтали не сработало, так как ширина столбца = ширине элемента
            children: <Widget>[
              Image.asset(image),
              Text(
                title, 
                style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Krasnodarskii krai, Anapa', style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.grey
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('|', style: TextStyle(color: Colors.grey),)),
                Text('\$' + price.toString(), style: TextStyle(
                  fontFamily: 'Oswald', color: Colors.grey
                ),),
              ],),
              Container(
                padding: EdgeInsets.all(10.0),
                
                child: Text(
                  description,
                  textAlign: TextAlign.left ,
              )),
              
          ],
        ))));
  }
}
