import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/widgets/gallery.dart';
import 'package:flutter_test_work/widgets/preloader.dart';

class AlbumScreenArgs {
  final int albumId;

  AlbumScreenArgs({
    required this.albumId,
  });
}

class AlbumScreen extends StatelessWidget {
  static const routeName = 'album';

  const AlbumScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as AlbumScreenArgs;

    return FutureBuilder<List>(
      future: Future.wait([
        ApiJsonPlaceholder.getAlbum(routeArgs.albumId),
        ApiJsonPlaceholder.getAlbumPhotos(routeArgs.albumId),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _Screen(
            album: snapshot.data![0],
            photos: snapshot.data![1],
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _Screen extends StatelessWidget {
  final AlbumModel album;
  final List<PhotoModel> photos;

  const _Screen({
    Key? key,
    required this.album,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Album: ${album.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Gallery(
          photos: photos,
        ),
      ),
    );
  }
}
