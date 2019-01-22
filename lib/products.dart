import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products) {
    print('[Products Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          //SizedBox(height: 10.0),
          Container(
            //margin: EdgeInsets.only(top: 20.0),
            //margin: EdgeInsets.symmetric(vertical: 15.0),
            padding: EdgeInsets.only(top: 20.0),
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                products[index]['title'],
                style: TextStyle(
                  fontSize: 26.0, 
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Oswald',
                  ),
                ),
                SizedBox(width: 8.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    '\$${products[index]['price'].toString()}', 
                    style: TextStyle(color: Colors.white),
                    ),
                ),
              ],)
          ),
          Text(products[index]['description']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.
                  pushNamed<bool>(context, '/product/${index.toString()}'),
              )
            ],
          ),
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
