import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(
          children: <Widget>[
            Text('On the Product Page'),
            RaisedButton(
              child: Text('BACK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ) 
      );
  }
}