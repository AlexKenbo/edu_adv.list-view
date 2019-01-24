import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String,dynamic>> products;

  ProductsPage(this.products);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        drawer: Drawer(
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
        ),
        appBar: AppBar(
          title: Text('Easy List'),
        ),
        body: ProductManager(products),
      );
    }

}