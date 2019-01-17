import 'package:flutter/material.dart';
import 'package:flutter_course/products.dart';
import 'package:flutter_course/product_control.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  //ProductManager({this.startingProduct = 'Option args'}) {
  ProductManager({this.startingProduct}) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  _ProductManagerState createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  final List<String> _products = [];

  @override
  void initState() {
    print('[ProductManager State] initState()');
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(_addProduct),
      ),
      Expanded(
        child: Products(_products)
      ),
    ]);
  }
}
