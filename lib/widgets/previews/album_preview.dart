import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/album_model.dart';
import 'package:flutter_test_work/models/photo_model.dart';
import 'package:flutter_test_work/screens/album_screen.dart';
import 'package:flutter_test_work/widgets/images/cached_network_image.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';

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
        future: ApiJsonPlaceholder.getAlbumPhotos(album.id).then((value) => value.first),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              contentPadding: const EdgeInsets.all(20),
              title: Text(
                album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CachedNetworkImage(
                url: snapshot.data!.thumbnailUrl,
                fit: BoxFit.fill,
              ),
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AlbumScreen.routeName,
                  arguments: AlbumScreenArgs(albumId: album.id),
                );
              },
            );
          } else {
            return const SizedBox(
              width: 352.7,
              height: 104,
              child: Preloader(),
            );
          }
        },
      ),
    );
  }
}
