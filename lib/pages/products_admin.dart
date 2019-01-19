import 'package:flutter/material.dart';
import 'package:flutter_course/pages/products.dart';
import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading:
                      false, //выкл. автоматическое добавление др. элементов, - иконка бутерброд
                  title: Text('Choose'),
                ),
                ListTile(
                  title: Text('All products'),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProductsPage();
                    }));
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Manage product'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: 'Create Product',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'My Products',
                  ),
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: <Widget>[
                ProductCreatePage(),
                ProductListPage(),
              ],
            ),
          ),
        ));
  }
}
