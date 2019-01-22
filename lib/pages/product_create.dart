import 'package:flutter/material.dart';


class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
    State<StatefulWidget> createState() {
      return _ProductCreatePagState();
    }
}

class _ProductCreatePagState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue =  '';
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value){
            setState(() {
            titleValue = value;           
            });
          },),
          TextField(
            decoration: InputDecoration(labelText: 'Product Descreption'),
            maxLines: 5,
            onChanged: (String value){
            setState(() {
            descriptionValue = value;           
            });
          },),
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value){
            setState(() {
            priceValue = double.parse(value);           
            });
          },),
          SizedBox(height: 10.0,),
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: (){
              final Map<String, dynamic> product = {
                'title': titleValue,
                'description': descriptionValue,
                'price': priceValue,
                'image': '/Users/santes/Documents/flutter_projects/flutter_course/assets/food.jpg',
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
          
        ],
    ));
  }
}