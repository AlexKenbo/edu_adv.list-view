import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';
import 'package:flutter_course/pages/products_admin.dart';

class ProductsPage extends StatelessWidget {
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
                title: Text('Manage products'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder:(BuildContext context){ 
                      return ProductsAdminPage();
                      }
                    )
                  );
                  
                },
              )

            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Easy List'),
        ),
        body: ProductManager(),
      );
    }

}