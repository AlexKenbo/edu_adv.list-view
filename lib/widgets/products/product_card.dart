import 'package:flutter/material.dart';
import './price_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);
  
  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
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
                    product['title'],
                    style: TextStyle(
                      fontSize: 26.0, 
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Oswald',
                      ),

                ),
                SizedBox(width: 8.0,),
                PriceTag(product['price'].toString()),
              ],)
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child:  Text('Krasnodarskii krai, Anapa'),
            
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.
                  pushNamed<bool>(context, '/product/${productIndex.toString()}'),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.
                  pushNamed<bool>(context, '/product/${productIndex.toString()}'),
              )
            ],
          ),
        ],
      ),
    );
  }
}