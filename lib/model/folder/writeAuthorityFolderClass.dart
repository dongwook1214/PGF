import 'dart:convert';

import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:cryptofile/model/crypto/aesKeyClass.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:cryptofile/model/dto/writeAuthorityFolderDTO.dart';
import 'package:cryptofile/model/folder/folderClass.dart';
import 'package:intl/intl.dart';

class WriteAuthorityFolderClass implements FolderClass {
  late String folderCP;
  late String folderPublicKey;
  late String folderPrivateKey;
  late bool isTitleOpen;
  late String title;
  late String symmetricKey;
  late DateTime lastChangedDate;

  WriteAuthorityFolderClass(
      this.folderCP,
      this.folderPublicKey,
      this.folderPrivateKey,
      this.isTitleOpen,
      this.title,
      this.symmetricKey,
      this.lastChangedDate);
  WriteAuthorityFolderClass.fromDTO(
      WriteAuthorityFolderDTO dto, RSAKeyPairClass rsaKeyPairClass) {
    folderCP = dto.folderCP;
    folderPublicKey = dto.folderPublicKey;
    folderPrivateKey = CryptoClass.asymmetricDecryptData(
        rsaKeyPairClass.privateKey, dto.folderPrivateKeyEWA);
    isTitleOpen = dto.isTitleOpen;
    symmetricKey = CryptoClass.asymmetricDecryptDataFromPem(
        folderPrivateKey, dto.symmetricKeyEWF);
    title = isTitleOpen
        ? dto.title
        : CryptoClass.symmetricDecryptData(
            AesKeyClass.fromString(symmetricKey), dto.title);

    lastChangedDate = DateTime.parse(dto.lastChangedDate);
  }

  @override
  String getFolderCP() {
    return folderCP;
  }

  @override
  String getPrivateKey() {
    return folderPrivateKey;
  }

  @override
  String getTitle() {
    return title;
  }

  @override
  String getPublicKey() {
    return folderPublicKey;
  }

  @override
  String getLastChangedDate() {
    return DateFormat.yMMMd().format(lastChangedDate);
  }

  @override
  String getSymmetricKey() {
    return symmetricKey;
  }
}
