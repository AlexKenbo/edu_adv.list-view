import 'package:flutter/material.dart';
import '../widgets/products/products.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/logout_list_tile.dart';
import '../widgets/ui_elements/adaptive_progress_indicated.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @required
  void initState() {
    widget.model.fetchProducts(); 
    super.initState();
  }
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
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
      Widget content = Center(child: Text('Product not found'));
      if (model.displayedProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if (model.isLoading) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Easy List'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.4,
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  });
            },
          ),
        ],
      ),
      body: _buildProductsList(),
    );
  }
}
