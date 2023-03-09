import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../designClass/dialogFormat.dart';

class ContactUsClass extends StatelessWidget {
  const ContactUsClass({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Contact Us'),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogFormat(
            image: Image.asset("images/coding.png"),
            okFunction: () {
              Navigator.pop(context);
            },
            tempDescription: "Email: dongwook1214@gmail.com",
            tempTitle: 'Contact Us',
          ),
        );
      },
    );
  }
}
