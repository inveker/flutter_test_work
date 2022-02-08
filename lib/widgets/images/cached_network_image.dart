import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CachedNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;

  const CachedNetworkImage({
    Key? key,
    required this.url,
    this.fit,
  }) : super(key: key);

  Future<String> _getImage(SharedPreferences prefs) async {
    final http.Response response = await http.get(Uri.parse(url));
    String? base64 = base64Encode(response.bodyBytes);
    await prefs.setString(url, base64);
    return base64;
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<SharedPreferences>();
    final imageData = prefs.getString(url);

    if (imageData != null) {
      return Image.memory(
        base64Decode(imageData),
        fit: fit,
      );
    } else {
      return FutureBuilder<String>(
        future: _getImage(prefs),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              base64Decode(snapshot.data!),
              fit: fit,
            );
          } else {
            return const Preloader(
              bgColor: Colors.transparent,
            );
          }
        },
      );
    }
  }
}
