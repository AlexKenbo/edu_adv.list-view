import 'package:flutter/material.dart';
import '../widgets/products/products.dart';

import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false, //выкл. автоматическое добавление др. элементов, - иконка бутерброд
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap: ()=>Navigator.pushReplacementNamed(context, '/admin'),
          ),
        ],
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Easy List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: (){},
            )
          ],
        ),
        body: Products(products),
      );
    }

}