import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BorderCard extends Card {
  Widget childWidget;
  BorderCard({
    super.key,
    required this.childWidget,
  }) : super(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: childWidget);

  static Widget contentsOfContents(Image image, String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: image,
          ),
          Container(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              Text(
                tooLongString(detail),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }

  static String tooLongString(String str) {
    if (str.length > 20) {
      return str.substring(0, 17) + "...";
    } else {
      return str;
    }
  }
}
