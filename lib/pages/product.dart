import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Center(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center, // выравнивание по вертикали. не используем тк с картинкой по центру не красиво
          crossAxisAlignment: CrossAxisAlignment
              .center, // выравнивание по горизонтали не сработало, так как ширина столбца = ширине элемента
          children: <Widget>[
            Image.asset(
                '/Users/santes/Documents/flutter_projects/list-view/assets/food.jpg'),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text('On the Product Page')),
            Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('BACK'),
                  onPressed: () => Navigator.pop(context),
                ))
          ],
        )));
  }
}
