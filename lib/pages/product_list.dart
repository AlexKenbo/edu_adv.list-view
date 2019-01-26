import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String,dynamic>> products;

  ProductListPage(this.products);

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile( 
          leading: Image(
            image: AssetImage(products[index]['image']), 
            height: 96.0, 
            width: 96.0, 
            fit: BoxFit.fitWidth,
            ),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            ),
        );
      },
      itemCount: products.length,
    );
  }
}