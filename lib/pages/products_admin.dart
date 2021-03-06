import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/logout_list_tile.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading:
                false, //выкл. автоматическое добавление др. элементов, - иконка бутерброд
            title: Text('Choose'),
            elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.4,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            }
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Manage product'),
            elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.4,
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
                ProductEditPage(),
                ProductListPage(model),
              ],
            ),
          ),
        ));
  }
}
