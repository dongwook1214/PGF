import 'package:get/get.dart';

class CreateNewFolderListTileGetX extends GetxController {
  bool isTitleOpen = false;
  void setIsTitleOpen(bool _isTitleOpen) {
    isTitleOpen = _isTitleOpen;
    update();
  }
}
