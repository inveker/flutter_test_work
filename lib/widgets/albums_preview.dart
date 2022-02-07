import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/screens/album_screen.dart';
import 'package:flutter_test_work/screens/albums_screen.dart';
import 'package:flutter_test_work/screens/post_screen.dart';
import 'package:flutter_test_work/screens/posts_screen.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:flutter_test_work/widgets/props_widget.dart';

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
          return _AlbumsPreviewProps(
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

class _AlbumsPreviewProps extends PropsWidget {
  final List<AlbumModel> albums;
  final int userId;

  _AlbumsPreviewProps({
    required this.albums,
    required this.userId,
  }) : super(child: _AlbumsPreview());
}

class _AlbumsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_AlbumsPreviewProps>();
    final albums = props.albums;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var album in albums)
          _AlbumPreview(
            album: album,
          ),
        _ShowMoreButton(),
      ],
    );
  }
}

class _ShowMoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_AlbumsPreviewProps>();
    final userId = props.userId;
    return TextButton(
      child: const Text('Show more'),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AlbumsScreen.routeName,
          arguments: AlbumsScreenArgs(userId: userId),
        );
      },
    );
  }
}

class _AlbumPreview extends StatelessWidget {
  final AlbumModel album;

  const _AlbumPreview({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: FutureBuilder<PhotoModel>(
        future: ApiJsonPlaceholder.getAlbumPreview(album.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              contentPadding: const EdgeInsets.all(20),
              title: Text(album.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
              leading: Image.network(
                snapshot.data!.thumbnailUrl,
                fit: BoxFit.fill,
              ),
            );
          } else {
            return const Preloader();
          }
        },
      ),
    );
  }
}
