import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:giff_dialog/giff_dialog.dart';

class DialogFormat extends AssetGiffDialog {
  String tempTitle;
  String? tempDescription;
  Widget? childWidget;
  Function() okFunction;
  bool? isLackOfSpace;
  DialogFormat({
    super.key,
    required super.image,
    required this.tempTitle,
    required this.okFunction,
    this.tempDescription,
    this.childWidget,
    this.isLackOfSpace,
  }) : super(
          title: Text(tempTitle),
          description: tempDescription == null
              ? null
              : Text(
                  tempDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(letterSpacing: 0.8),
                ),
          isLackOfSpace: isLackOfSpace,
          childWidget: childWidget,
          entryAnimation: EntryAnimation.bottomRight,
          onOkButtonPressed: () {
            //Navigator.pop(context);
            okFunction();
          },
        );
}
