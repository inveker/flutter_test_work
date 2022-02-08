import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteLink extends StatelessWidget {
  final String url;

  const WebsiteLink({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(url),
      onPressed: () async {
        final url = 'https:${this.url}';
        if (await canLaunch(url)) {
          launch(url);
        }
      },
    );
  }
}
