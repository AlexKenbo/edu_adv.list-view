import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  final Widget child;

  ImageInput({Key key, this.child}) : super(key: key);

  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).accentColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
          onPressed: (){
            
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt, color: buttonColor),
              SizedBox(
                width: 5.0,
              ), 
              Text('Add Image', style: TextStyle(color: buttonColor),)
            ],
          ),
        )
      ],
    );
  }
}
