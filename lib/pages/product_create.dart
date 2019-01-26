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
  String _titleValue = '';
  String _descriptionValue =  '';
  double _priceValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleField(){
    return TextFormField(
      //autovalidate: true, 
      validator: (String value) {
        //if (value.trim().length <= 0){
        if (value.isEmpty){  
          return 'title is required';
        }
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String value){
        setState(() {
          _titleValue = value;        
        });
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(labelText: 'Product Descreption'),
      keyboardType: TextInputType.number,
      onSaved: (String value){
        setState(() {
          _descriptionValue = value;        
        });
      }
      );
  }

  Widget _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onSaved: (String value){
        setState(() {
          _priceValue = double.parse(value);        
        });
      }
      );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': '/Users/santes/Documents/flutter_projects/list-view/assets/food.jpg',
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal:targetPadding/2),
          children: <Widget>[
            _buildTitleField(), 
            _buildDescriptionField(),
            _buildPriceField(),
            SizedBox(height: 10.0,),
            RaisedButton(
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: _submitForm,
            ),
            
            /*GestureDetector( // Кастомная кнопка
              onTap: _submitForm,
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text('Custom button'),
              ),
            )*/
          ],
    )));
  }
}