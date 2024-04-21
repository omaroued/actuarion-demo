import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class RequestImageDetailsScreen extends StatefulWidget {
  final List<String> images;
  final int initialPosition;
  const RequestImageDetailsScreen({super.key, required this.images, required this.initialPosition});

  @override
  State<RequestImageDetailsScreen> createState() => _RequestImageDetailsScreenState();
}

class _RequestImageDetailsScreenState extends State<RequestImageDetailsScreen> {
  late final _pageController = PageController(initialPage: widget.initialPosition);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(widget.images[index])),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              );
            },
            itemCount: widget.images.length,
            pageController: _pageController,
          ),
          Positioned(
            top: 6,
            left: 6,
            child: SafeArea(
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
