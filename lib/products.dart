import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products([this.products = const [] ]) {
    print('[Products Widget] Constructor');
  }
  
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column( 
        children: <Widget>[
          Image.asset('/Users/santes/Documents/flutter_projects/list-view/assets/food.jpg'),
          Text(products[index])
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCard;
      if (products.length > 0) {
        productCard = ListView.builder( 
        //Подгружает постепенно элементы списка
        //Хорош на big-списках
        itemBuilder: _buildProductItem,
        itemCount: products.length,
        );
      } else {
        productCard = Center(child: Text('Products is empty'),);
      }
    return productCard; 
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }

}