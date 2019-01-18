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
    Widget productCards;
      if (products.length > 0) {
        productCards = ListView.builder( 
        //Подгружает постепенно элементы списка
        //Хорош на big-списках
        itemBuilder: _buildProductItem,
        itemCount: products.length,
        );
      } else {
        productCards = Container();
      }
    return productCards; 
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }

}