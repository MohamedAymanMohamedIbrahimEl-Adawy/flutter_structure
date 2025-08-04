import 'dart:convert';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, this.img});

  final String? img;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.img != null)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 100,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.memory(
                      const Base64Decoder().convert(widget.img ?? ''),
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
