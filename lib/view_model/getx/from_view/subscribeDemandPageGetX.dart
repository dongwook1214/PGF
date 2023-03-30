import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:get/get.dart';

class subscribeDemandPageGetX extends GetxController {
  List<String> subscribeDemandList = [];
  Future setSubscribeDemandList(String folderCP) async {
    subscribeDemandList = [];
    DioHandling dioHandling = DioHandling();
    subscribeDemandList = await dioHandling.getSubscribeDemands(folderCP);
    update();
  }
}
