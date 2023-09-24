import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowImageZoom(url: url)));
                },
                child: Image.network(url, fit: BoxFit.fitHeight)),
          ),
        ));
  }
}

class ShowImageZoom extends StatelessWidget {
  const ShowImageZoom({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
