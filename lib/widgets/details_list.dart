import 'package:flutter/material.dart';

Widget titleDetail(
    {required String detail,
    required String title,
    required CrossAxisAlignment crossAxisAlignment}) {
  return Column(
    crossAxisAlignment: crossAxisAlignment,
    children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      Text(detail,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0))
    ],
  );
}
