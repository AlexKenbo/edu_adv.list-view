import 'package:flutter/material.dart';

import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductsAdminPage(this.addProduct, this.deleteProduct);

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
                  leading: Icon(Icons.shop),
                  title: Text('All products'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  }
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
                ProductCreatePage(addProduct),
                ProductListPage(),
              ],
            ),
          ),
        ));
  }
}
