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

  @override
    Widget build(BuildContext context) {
      print('[Products Widget] build()');
      // TODO: implement build
      /* 
      //ListView хорош на недлинных списках, 
      //он прогружает на экран весь список
      return ListView( 
          children: 
            products
              .map(
                (element) => Card(
                    child: Column( 
                      children: <Widget>[
                        Image.asset('/Users/santes/Documents/flutter_projects/list-view/assets/food.jpg'),
                        Text(element)
                      ],
                    ),
                  ),
              ).toList()
        );
      */
      return products.length > 0 ? ListView.builder( 
        //Подгружает постепенно элементы списка
        //Хорош на big-списках
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      ) : Center(child: Text('Products is empty'),);
    }

}