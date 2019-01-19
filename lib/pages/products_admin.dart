import 'package:flutter/material.dart';
import 'package:flutter_course/pages/products.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false, //выкл. автоматическое добавление др. элементов, - иконка бутерброд
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('All products'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder:(BuildContext context){ 
                      return ProductsPage();
                      }
                    )
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage product'),
        ),
        body: Center(
          child: Text('Manage product this'),
        ),
      );
  }
}