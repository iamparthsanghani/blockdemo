import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomRoundCornerImage extends StatelessWidget {
  final double height;
  final double width;
  final String image;
  final File fileImage;
  final String placeholder;
  final double topRightCorner,
      topLeftCorner,
      bottomLeftCorner,
      bottomRightCorner;

  CustomRoundCornerImage(
      {this.height,
        this.width,
        this.image,
        this.fileImage,
        this.placeholder,
        this.topRightCorner,
        this.topLeftCorner,
        this.bottomLeftCorner,
        this.bottomRightCorner});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftCorner),
          topRight: Radius.circular(topRightCorner),
          bottomRight: Radius.circular(bottomRightCorner),
          bottomLeft: Radius.circular(bottomLeftCorner),
        ),
        child: CachedNetworkImage(
          width: width,
          height: height,
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => Container(
              child: Center(
                  child: new CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.black)))),
          errorWidget: (context, url, error) => Container(
            height: width,
            width: height,
            decoration: BoxDecoration(
              /*  color: Color(0xFFdbdbdb),*/
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeftCorner),
                topRight: Radius.circular(topRightCorner),
                bottomRight: Radius.circular(bottomRightCorner),
                bottomLeft: Radius.circular(bottomLeftCorner),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: fileImage == null
                      ? AssetImage(('assets/$placeholder'))
                      : FileImage(fileImage)),
              /* new Image.asset('assets/test.jpg')*/
            ),
          ),
        ),
      ),
    );
  }
}
