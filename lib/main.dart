import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/app.dart';

void main() {
  ApiJsonPlaceholder.getAlbumPreview(2);
  runApp(App());
}