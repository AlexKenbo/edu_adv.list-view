import 'package:flutter/material.dart';


class ProductCreatePage extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _ProductCreatePagState();
    }
}

class _ProductCreatePagState extends State<ProductCreatePage> {
  String title = '';
  String description =  '';
  double price;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value){
            setState(() {
            title = value;           
            });
          },),
          TextField(
            decoration: InputDecoration(labelText: 'Product Descreption'),
            maxLines: 12,
            onChanged: (String value){
            setState(() {
            description = value;           
            });
          },),
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value){
            setState(() {
            price = double.parse(value);           
            });
          },),
          
        ],
    ));
  }
}