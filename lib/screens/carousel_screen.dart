import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/widgets/carousel.dart';
import 'package:flutter_test_work/widgets/preloader.dart';

class CarouselScreenArgs {
  final int albumId;
  final int position;

  CarouselScreenArgs({
    required this.albumId,
    required this.position,
  });
}

class CarouselScreen extends StatelessWidget {
  static const routeName = 'carousel';

  const CarouselScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarouselScreenArgs routeArgs = ModalRoute
        .of(context)!
        .settings
        .arguments as CarouselScreenArgs;

    return FutureBuilder<List<PhotoModel>>(
      future: ApiJsonPlaceholder.getAlbumPhotos(routeArgs.albumId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _Screen(
            photos: snapshot.data!,
            position: routeArgs.position,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _Screen extends StatelessWidget {
  final List<PhotoModel> photos;
  final int position;

  const _Screen({
    Key? key,
    required this.photos,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carousel'),
        ),
        body: Carousel(
          photos: photos,
          position: position,
        ),
      ),
    );
  }
}
