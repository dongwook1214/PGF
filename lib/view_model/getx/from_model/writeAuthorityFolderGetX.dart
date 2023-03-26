import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/writeAuthorityFolderDTO.dart';
import 'package:cryptofile/model/folder/writeAuthorityFolderClass.dart';
import 'package:cryptofile/model/prefsHandling/prefsHandling.dart';
import 'package:cryptofile/view_model/getx/from_model/accountGetX.dart';
import 'package:get/get.dart';

class WriteAuthorityFolderGetX extends GetxController {
  List<WriteAuthorityFolderClass> folderList = <WriteAuthorityFolderClass>[];
  Future setFolderList() async {
    if (Get.find<AccountGetX>().myAccount == null) {
      return;
    }
    folderList = [];
    DioHandling dioHandling = DioHandling();
    RSAKeyPairClass rsaKeyPair = Get.find<AccountGetX>().myAccount!;
    String accountCP =
        Get.find<AccountGetX>().myAccount!.getCompressedPublicKeyString();
    List<WriteAuthorityFolderDTO> writeAuthorityFolderDTOList =
        await dioHandling.getWriteAuthByAccountCP(accountCP);
    for (WriteAuthorityFolderDTO dto in writeAuthorityFolderDTOList) {
      folderList.add(WriteAuthorityFolderClass.fromDTO(dto, rsaKeyPair));
    }
    print("setRxList Fisnish");
    update();
  }
}
