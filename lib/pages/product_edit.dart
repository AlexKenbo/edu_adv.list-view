import 'dart:io';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../widgets/form_inputs/location.dart';
import '../widgets/form_inputs/image.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';
import '../models/location_date.dart';

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
    'image': null,
    'location': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _priceTextController =TextEditingController();

  Widget _buildTitleField(Product product) {
    if (product == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (product != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = product.title;
    } else if (product != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (product == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }
    return EnsureVisibleWhenFocused(
        focusNode: _titleFocusNode,
        child: TextFormField(
          focusNode: _titleFocusNode,
          //initialValue: product == null ? '' : product.title,
          //autovalidate: true,
          validator: (String value) {
            //if (value.trim().length <= 0){
            if (value.isEmpty || value.length < 5) {
              return 'Title is required and should be 5+ characters long';
            }
          },
          decoration: InputDecoration(labelText: 'Product Title'),
          controller: _titleTextController,
          onSaved: (String value) {
            _formData['title'] = value;
          },
        ));
  }

  Widget _buildDescriptionField(Product product) {
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    } 
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: TextFormField(
            focusNode: _descriptionFocusNode,
            //initialValue: product == null ? '' : product.description,
            controller: _descriptionTextController,
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
    if (product == null && _priceTextController.text.trim() == '') {
      _priceTextController.text = '';
    } else if (product != null && _priceTextController.text.trim() == '') {
      _priceTextController.text = product.price.toString();
    } 
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: TextFormField(
            focusNode: _priceFocusNode,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            //initialValue: product == null ? '' : product.price.toString(),
            controller: _priceTextController,
            validator: (String value) {
              //if (value.trim().length <= 0){
              if (value.isEmpty ||
                  !RegExp(r'[0-9]*(\.[0-9]+)?').hasMatch(value)) {
                return 'Price is required and should be number';
              }
            },
            decoration: InputDecoration(labelText: 'Product Price'),
            onSaved: (String value) {
              _formData['price'] = double.parse(value);
            }));
  }

  void _setLocation(LocationData locData) {
    _formData['location'] = locData;
  }

  void _setImage(File image) {
    _formData['image'] = image;
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate() || (_formData['image'] == null && selectedProductIndex == -1)) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
        _titleTextController.text, 
        _descriptionTextController.text,
        _formData['image'], 
        double.parse(_priceTextController.text),
        _formData['location'])
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay!'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _titleTextController.text, 
        _descriptionTextController.text,
        _formData['image'], 
        double.parse(_priceTextController.text),
        _formData['location'])
          .then((_) => Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null)));
    }
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.isLoading
          ? Center(child: CircularProgressIndicator())
          : RaisedButton(
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () => _submitForm(
                  model.addProduct,
                  model.updateProduct,
                  model.selectProduct,
                  model.selectedProductIndex),
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
                    LocationInput(_setLocation, product),
                    SizedBox(
                      height: 10.0,
                    ),
                    ImageInput(_setImage, product),
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
      final Widget pageContent =
          _buildPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == -1
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
