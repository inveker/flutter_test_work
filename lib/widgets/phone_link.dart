import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneLink extends StatelessWidget {
  final String phone;

  const PhoneLink({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(phone),
      onPressed: () async {
        final url = 'tel:$phone';
        if (await canLaunch(url)) {
          launch(url);
        }
      },
    );
  }
}
