import 'package:flutter/material.dart';
import 'package:flutter_test_work/widgets/data_fields/field_title.dart';

class MultiField extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MultiField({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldTitle(
            title: title,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
