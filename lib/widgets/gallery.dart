import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatelessWidget {
  final List<PhotoModel> photos;

  const Gallery({
    Key? key,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: photos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          child: InkWell(
            child: Image.network(photo.url),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => _Carousel(photos: photos, position: index)));
            },
          ),
        );
      },
    );
  }
}

class _Carousel extends StatelessWidget {
  final List<PhotoModel> photos;
  final int position;

  const _Carousel({
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
          // initialScale: PhotoViewComputedScale.contained * 0.8,
          minScale: 1.0,
          heroAttributes: PhotoViewHeroAttributes(tag: photo.id),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Image.network(photo.url),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(20),
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
