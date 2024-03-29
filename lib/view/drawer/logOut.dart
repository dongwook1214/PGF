import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/getx/from_model/accountGetX.dart';
import '../designClass/dialogFormat.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _ImportExistingFolderState();
}

class _ImportExistingFolderState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Log Out'),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogFormat(
            image: Image.asset("images/bury.png"),
            tempDescription:
                "As long as you have the key pair for your account, you can get your account and folders back at any time.",
            okFunction: () => logOutFounc(),
            tempTitle: 'Log Out',
            isLackOfSpace: true,
          ),
        );
      },
    );
  }

  Future logOutFounc() async {
    Get.find<AccountGetX>().logOut();
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
