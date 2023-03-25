import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TitleAndDescriptionFormat extends StatefulWidget {
  IconData iconData;
  String title;
  String description;
  Widget? actionWidget;
  TitleAndDescriptionFormat(
      {super.key,
      required this.iconData,
      required this.title,
      required this.description,
      this.actionWidget});

  @override
  State<TitleAndDescriptionFormat> createState() =>
      _TitleAndDescriptionFormatState();
}

class _TitleAndDescriptionFormatState extends State<TitleAndDescriptionFormat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(widget.iconData),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  ${widget.title}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Text(
                  "  ${widget.description}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        widget.actionWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
