import 'package:flutter/material.dart';
import 'package:image_saerch/domain/model/photo_model.dart';

class PhotoWidget extends StatelessWidget {
  final PhotoModel photo;

  const PhotoWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(photo.previewURL),
          )),
    );
  }
}
