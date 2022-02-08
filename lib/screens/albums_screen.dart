import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/widgets/previews/album_preview.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';

class AlbumsScreenArgs {
  final int userId;

  AlbumsScreenArgs({
    required this.userId,
  });
}

class AlbumsScreen extends StatelessWidget {
  static const routeName = 'albums';

  const AlbumsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumsScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as AlbumsScreenArgs;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Albums'),
        ),
        body: FutureBuilder<List<AlbumModel>>(
          future: ApiJsonPlaceholder.getAlbums(routeArgs.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _AlbumsList(
                albums: snapshot.data!,
              );
            } else {
              return const Preloader();
            }
          },
        ),
      ),
    );
  }
}


class _AlbumsList extends StatelessWidget {
  final List<AlbumModel> albums;

  const _AlbumsList({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return AlbumPreview(album: album);
      },
    );
  }
}
