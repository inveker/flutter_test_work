import 'package:flutter/material.dart';

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

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Album Screen ${routeArgs.albumId}'),
        ),
      ),
    );
  }
}
