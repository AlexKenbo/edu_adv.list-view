import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
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

  Widget _buildTitleField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _titleFocusNode,
        child: TextFormField(
          focusNode: _titleFocusNode,
          initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: TextFormField(
            focusNode: _descriptionFocusNode,
            initialValue: product == null ? '' : product.description,
            validator: (String value) {
              //if (value.trim().length <= 0){
              if (value.isEmpty || value.length < 10) {
                return 'Descrition is required and should be 10+ characters long';
              }
            },
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Product Descreption'),
            onSaved: (String value) {
              _formData['description'] = value;
            }));
  }

  Widget _buildPriceField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: TextFormField(
            focusNode: _priceFocusNode,
            initialValue:
                product == null ? '' : product.price.toString(),
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

  void _submitForm(Function addProduct, Function updateProduct, Function setSelectedProduct, [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price']);
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price']);
    }
    Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null));
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return RaisedButton(
        textColor: Colors.white,
        child: Text('Save'),
        onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct, model.selectedProductIndex),
      );
    });
  }

  Widget _buildPageContent(BuildContext context, Product product) {
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
                    _buildTitleField(product),
                    _buildDescriptionField(product),
                    _buildPriceField(product),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSubmitButton(),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit product'),
              ),
              body: pageContent,
            );
    });
  }
}
