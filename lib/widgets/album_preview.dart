import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/widgets/preloader.dart';

class AlbumPreview extends StatelessWidget {
  final AlbumModel album;

  const AlbumPreview({
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
              title: Text(
                album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
