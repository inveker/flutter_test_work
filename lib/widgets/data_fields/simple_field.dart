import 'package:flutter/material.dart';
import 'package:flutter_test_work/widgets/data_fields/field_title.dart';

class SimpleField extends StatelessWidget {
  final String title;
  final Widget value;

  const SimpleField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FieldTitle(
            title: title,
          ),
          const SizedBox(width: 16,),
          Flexible(
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
              child: value,
            ),
          ),
        ],
      ),
    );
  }
}
