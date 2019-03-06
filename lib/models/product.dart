import 'package:flutter/material.dart';

import './location_date.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String imagePath;
  final bool isFavorite;
  final String userEmail;
  final String userId;
  final LocationData location;

  Product({
    @required this.id,
    @required this.title, 
    @required this.description, 
    @required this.price, 
    @required this.image,
    @required this.imagePath,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false,
    @required this.location});

}