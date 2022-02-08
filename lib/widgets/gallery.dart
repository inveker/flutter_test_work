import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/screens/carousel_screen.dart';
import 'package:flutter_test_work/widgets/carousel.dart';

import 'cached_network_image.dart';

class Gallery extends StatelessWidget {
  final List<PhotoModel> photos;
  final int albumId;

  const Gallery({
    Key? key,
    required this.photos,
    required this.albumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          child: InkWell(
            child: CachedNetworkImage(
              url: photo.url,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                CarouselScreen.routeName,
                arguments: CarouselScreenArgs(
                  albumId: albumId,
                  position: index,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
