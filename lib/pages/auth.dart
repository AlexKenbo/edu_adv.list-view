import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.4),
        BlendMode.dstATop,
      ),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)')
                .hasMatch(value)) {
          return 'Email is required and should be email address';
        }
      },
      decoration: InputDecoration(
        labelText: 'Your Email',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 4) {
          return 'Password is required and should be +3 charsets long';
        }
      },
      decoration: InputDecoration(
        labelText: 'Your Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Password do not match.';
        }
      },
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
    );
  }

  Widget _buildAcceptTerms() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      title: Text('Accept terms'),
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  void _onSubmitForm(Function login, Function signup) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    if (_authMode == AuthMode.Login) {
      successInformation = await login(_formData['email'], _formData['password']);
    } else {
      successInformation = await signup(_formData['email'], _formData['password']);
    }
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
      }
    
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(24.0),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                    width: targetWidth,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            _buildEmailField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _authMode == AuthMode.Signup
                                ? _buildPasswordConfirmField()
                                : Container(),
                            _buildAcceptTerms(),
                            SizedBox(
                              height: 10.0,
                            ),
                            FlatButton(
                              child: Text(
                                  'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                              onPressed: () {
                                setState(() {
                                  _authMode = _authMode == AuthMode.Login
                                      ? AuthMode.Signup
                                      : AuthMode.Login;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ScopedModelDescendant<MainModel>(
                              builder: (BuildContext context, Widget child,
                                  MainModel model) {
                                return model.isLoading
                                    ? CircularProgressIndicator()
                                    : RaisedButton(
                                        textColor: Colors.white,
                                        child: Text(_authMode == AuthMode.Login
                                            ? 'LOGIN'
                                            : 'SIGNUP'),
                                        onPressed: () => _onSubmitForm(
                                            model.login, model.signup),
                                      );
                              },
                            ),
                          ],
                        ))))),
      ),
    );
  }
}
