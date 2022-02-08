import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/screens/albums_screen.dart';
import 'package:flutter_test_work/widgets/previews/album_preview.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';
import 'package:flutter_test_work/widgets/buttons/show_more_button.dart';

class AlbumsPreview extends StatelessWidget {
  final int userId;
  final int count;

  const AlbumsPreview({
    Key? key,
    required this.userId,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: ApiJsonPlaceholder.getAlbums(userId, count: count),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _AlbumsPreview(
            albums: snapshot.data!,
            userId: userId,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _AlbumsPreview extends StatelessWidget {
  final List<AlbumModel> albums;
  final int userId;

  const _AlbumsPreview({
    required this.albums,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var album in albums)
          AlbumPreview(
            album: album,
          ),
        ShowMoreButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AlbumsScreen.routeName,
              arguments: AlbumsScreenArgs(userId: userId),
            );
          },
        ),
      ],
    );
  }
}