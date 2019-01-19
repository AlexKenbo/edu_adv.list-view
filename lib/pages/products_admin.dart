import 'package:flutter/material.dart';
import 'package:flutter_course/pages/products.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Manage product'),
        ),
        body: Center(
          child: Text('Manage product this'),
        ),
      );
  }
}