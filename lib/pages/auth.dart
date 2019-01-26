import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTermsValue = false;

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
    return TextField(
      decoration: InputDecoration(
        labelText: 'Your Email',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Your Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _passwordValue = value;
        });
      },
    );
  }

  Widget _buildAcceptTerms() {
    return SwitchListTile(
      value: _acceptTermsValue,
      title: Text('Accept terms'),
      onChanged: (bool value) {
        setState(() {
          _acceptTermsValue = value;
        });
      },
    );
  }

  void _onSubmitForm() {
    print('$_emailValue:$_passwordValue');
    Navigator.pushReplacementNamed(context, '/products');
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
                    child: Column(
                      children: <Widget>[
                        _buildEmailField(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordField(),
                        _buildAcceptTerms(),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          child: Text('LOGIN'),
                          onPressed: _onSubmitForm,
                        ),
                      ],
        )))),
      ),
    );
  }
}
