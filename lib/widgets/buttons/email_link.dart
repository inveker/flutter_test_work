import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailLink extends StatelessWidget {
  final String email;

  const EmailLink({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(email),
      onPressed: () async {
        final url = 'mailto:$email';
        if (await canLaunch(url)) {
          launch(url);
        }
      },
    );
  }
}
