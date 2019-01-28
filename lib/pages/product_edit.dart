import 'package:flutter/material.dart';


class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;

  ProductEditPage({this.addProduct, this.updateProduct, this.product});

  @override
    State<StatefulWidget> createState() {
      return _ProductEditPageState();
    }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'descreption': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleField(){
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['title'],
      //autovalidate: true, 
      validator: (String value) {
        //if (value.trim().length <= 0){
        if (value.isEmpty || value.length < 5){  
          return 'Title is required and should be 5+ characters long';
        }
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String value){
        _formData['title'] = value;        
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['description'],
      validator: (String value) {
        //if (value.trim().length <= 0){
        if (value.isEmpty || value.length < 10){  
          return 'Descrition is required and should be 10+ characters long';
        }
      },
      maxLines: 5,
      decoration: InputDecoration(labelText: 'Product Descreption'),
      keyboardType: TextInputType.number,
      onSaved: (String value){
        _formData['description'] = value;        
      }
      );
  }

  Widget _buildPriceField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['price'].toString(),
      validator: (String value) {
        //if (value.trim().length <= 0){
        if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\[.,]\d+)?$').hasMatch(value)){  
          return 'Price is required and should be number';
        }
      },
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onSaved: (String value){
        _formData['price'] = double.parse(value);        
      }
      );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
    ))));

    return widget.product == null
      ? pageContent
      : Scaffold(
        appBar: AppBar(title: Text('Edit product'),),
        body: pageContent,
      );
  }
}