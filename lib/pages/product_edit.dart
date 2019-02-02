import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';

import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

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
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleField() {
    return EnsureVisibleWhenFocused(
        focusNode: _titleFocusNode,
        child: TextFormField(
          focusNode: _titleFocusNode,
          initialValue: widget.product == null ? '' : widget.product.title,
          //autovalidate: true,
          validator: (String value) {
            //if (value.trim().length <= 0){
            if (value.isEmpty || value.length < 5) {
              return 'Title is required and should be 5+ characters long';
            }
          },
          decoration: InputDecoration(labelText: 'Product Title'),
          onSaved: (String value) {
            _formData['title'] = value;
          },
        ));
  }

  Widget _buildDescriptionField() {
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: TextFormField(
            focusNode: _descriptionFocusNode,
            initialValue: widget.product == null ? '' : widget.product.title,
            validator: (String value) {
              //if (value.trim().length <= 0){
              if (value.isEmpty || value.length < 10) {
                return 'Descrition is required and should be 10+ characters long';
              }
            },
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Product Descreption'),
            keyboardType: TextInputType.number,
            onSaved: (String value) {
              _formData['description'] = value;
            }));
  }

  Widget _buildPriceField() {
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: TextFormField(
            focusNode: _priceFocusNode,
            initialValue:
                widget.product == null ? '' : widget.product.price.toString(),
            validator: (String value) {
              //if (value.trim().length <= 0){
              if (value.isEmpty ||
                  !RegExp(r'^(?:[1-9]\d*|0)?(?:\[.,]\d+)?$').hasMatch(value)) {
                return 'Price is required and should be number';
              }
            },
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onSaved: (String value) {
              _formData['price'] = double.parse(value);
            }));
  }

  void _submitForm(Function addProduct, Function updateProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      addProduct(Product(
          title: _formData['title'],
          description: _formData['description'],
          image: _formData['image'],
          price: _formData['price']));
    } else {
      updateProduct(
          widget.productIndex,
          Product(
              title: _formData['title'],
              description: _formData['description'],
              image: _formData['image'],
              price: _formData['price']));
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return RaisedButton(
        textColor: Colors.white,
        child: Text('Save'),
        onPressed: () => _submitForm(model.addProduct, model.updateProduct),
      );
    });
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  children: <Widget>[
                    _buildTitleField(),
                    _buildDescriptionField(),
                    _buildPriceField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSubmitButton(),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);

    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit product'),
            ),
            body: pageContent,
          );
  }
}
