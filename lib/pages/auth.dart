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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), 
              BlendMode.dstATop,
              ),
            image: AssetImage('assets/background.jpg'),
          )
        ),
        padding: EdgeInsets.all(24.0),
        child: ListView(
          children: <Widget>[
          TextField(
            decoration: 
              InputDecoration(
                labelText: 'Your Email'
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value){
              setState(() {
                _emailValue = value;
              });
            },
          ),
          TextField(
            decoration: 
              InputDecoration(
                labelText: 'Your Password'
            ),
            obscureText: true,
            onChanged: (String value){
              setState(() {
                _passwordValue = value;
              });
            },
          ),  
          SwitchListTile(
            value: _acceptTermsValue,
            title: Text('Accept terms'),
            onChanged: (bool value){
              setState(() {
                _acceptTermsValue = value;
              });
            },
          ),
          SizedBox(height: 10.0,),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('LOGIN'),
            onPressed: () {
              print('$_emailValue:$_passwordValue');
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
          ],
        ),
      ),
    );
  }
}
