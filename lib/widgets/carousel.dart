import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/widgets/cached_network_image.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Carousel extends StatelessWidget {
  final List<PhotoModel> photos;
  final int position;

  const Carousel({
    Key? key,
    required this.photos,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        final photo = photos[index];
        return PhotoViewGalleryPageOptions.customChild(
          minScale: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: CachedNetworkImage(url: photo.url,),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Text(
                      photo.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: photos.length,
      loadingBuilder: (context, event) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      pageController: PageController(
        initialPage: position,
      ),
    );
  }
}
