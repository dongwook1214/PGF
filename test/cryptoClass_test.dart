import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cryptofile/crypto/RSAKeyPairClass.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:cryptofile/crypto/cryptoClass.dart";
import 'package:rsa_encrypt/rsa_encrypt.dart';

void main() {
  test('비대칭 암호화 테스트', () async {
    String longText = "dfs";
    print(longText.length);
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    String encrypted =
        CryptoClass.asymmetricEncryptData(keyPair.publicKey, longText);
    String decrypted =
        CryptoClass.asymmetricDecryptData(keyPair.privateKey, encrypted);
    print(decrypted);
  });

  test('test', () async {
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    print(keyPair.getPrivateKeyString());
    print(keyPair.getPublicKeyString());
    // print(keyPair.getPrivateKeyString().length);
    // print(keyPair.getPublicKeyString().length);
  });

  test('sha256 test', () async {
    print(CryptoClass.sha256hash("fsdfsgjyghgjhgjh"));
  });

  test('test', () async {
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    String plainText = "hi";
    String pemPrivate = '''-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCbC+BiKA7EcfGRjklBnfgUTy6BucH4nPFHwQhS6U2szq4CpkPd4jFw3JqIc9y75NEbqbWHm+8BE2CHhO50DsU3EyVBefUoejlLqR426bNqeFW9/lUEFi4E4def+YoIny1eCAe3tMVUmA8YMe3vbb2Gc6mB9+xAVBfSEZSi0vlB9PkbdAbeTYhSzGPElucOcO3+Gd/del0FAi4w92p9uNsLEuOb08UMYK+Jyh2ivOF9C+xlnv/p+eSxptcb8Fthh9GZciS/yGHNR1GhJ3u22s6knZU+DaVUNbmkCrlu5vQKPWqiiTHoPVvj2RJ2RTp+siKm/OFnJXg4HUMB1TQt3UCNAgMBAAECggEAYyqkeIOAdnsec+eayUI9UtgWOdjSzK2s0SUQqt8X1EhZGc64J6mtz675k/7vFqpSaKwSNEszAfAf1G3cihSMZR50vL1BZYNPNCpV7e9p1tZimOOcAsIg6vR8EpDrjXop7TObpA8WC3Y6aVI+Cd6Z0u4VY9BrpfVjSvP9qmrgDCOhabwwHT3XxmaHBvmVN7IrMhvo5Lfy0IyHVpYrMqbv7rAu5Dk9eVlvIV7gmKBt9mOHOSuNOSIeJ4YTTQMTojID6GD4K+lGucgCocke9/Wk6qgLCFBBqr/Qlh8EmoBGmlIUJFPR+neBf+u67HzThxzjoR3xS1oxQf3E3Ndc5s1x7QKBgQDLwPmY4hiTpEP0ky8mp0cS1eHykLs00MY4quX04oDVXOHAF6FbBvQBBMMJXtQuqfV62Rpo017EzzSyIqFmV2IafpNIiOSLqbQlgKzDGKlmjkcvnG8vlxJPAO2ZpwXxJ1cMmTJYxfrFa9TnLKDCTBgNADoWjLOAW6daEfL0TmJsgwKBgQDCzZjpgLrF3JYYAhN2pLE4Fx4LTqjFQBrPLmtMmMsc9SoM++rsgZ4AW9cFXdDmnyqcvEpo2g/oHvSnDYiU8ILQfZoefdw6n0SOfH5bRGr+Puu4+b7jzG8oRoqnfoM6EX0FAf4NWwyLXoXiFYrkW8M5l8a0ZRo+xzHc+adzLfAxrwKBgDaQEMb+FPLElGYUXBYPyZqjqAQa+ebk2ZAnQ7lWRoXcf5+/NDh6HjF/ovMJb+ynGtOw+7+CiuhNTKE/YNVVJTJPHwXXksxLv7AjSyBbpFGQXEPFsoid/gsmBnqVHaQ8krUO+UqIieUAQV0+uDYPxokEvIl5WEBRSvl1wQfnTbgdAoGAX1ohwhIn2hfqRCAoBMgCkxEFvMUo6TxCoyz2ioyzxx3eEnLxAAlGHKjXrCHK0kgQpJ2p0n8CkD0uxeJi+3xqm8EPQmOa+/rfpNsdQnFP6dlEqstce8aillVJI0lS1Iag6mWaRFFP55xB7nNbBAJCohs/wSdH3HjGWIK/SyquSrMCgYB0zXGx5zslbFhlXvMCrwjin15WzuRLUzAEkEi4/8Tv94Bw+GAHtF9QZKccLVyrFk4qtRe08fuGdJFTqbyDRTPBxfurB1prrYaEIiuN1HJ6KKQLKaFX49MbEsdoOCVTEaHZssborB73M7xtBG0iYIixXqvuk7axRg5RQ8G303+Mww==
-----END PRIVATE KEY-----''';
    String pemPublic = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmwvgYigOxHHxkY5JQZ34FE8ugbnB+JzxR8EIUulNrM6uAqZD3eIxcNyaiHPcu+TRG6m1h5vvARNgh4TudA7FNxMlQXn1KHo5S6keNumzanhVvf5VBBYuBOHXn/mKCJ8tXggHt7TFVJgPGDHt7229hnOpgffsQFQX0hGUotL5QfT5G3QG3k2IUsxjxJbnDnDt/hnf3XpdBQIuMPdqfbjbCxLjm9PFDGCvicodorzhfQvsZZ7/6fnksabXG/BbYYfRmXIkv8hhzUdRoSd7ttrOpJ2VPg2lVDW5pAq5bub0Cj1qookx6D1b49kSdkU6frIipvzhZyV4OB1DAdU0Ld1AjQIDAQAB
-----END PUBLIC KEY-----''';

    RsaKeyHelper helper = RsaKeyHelper();
    String encrypted = CryptoClass.asymmetricEncryptData(
        helper.parsePublicKeyFromPem(pemPublic), plainText);
    print(encrypted);

    String decrypted = CryptoClass.asymmetricDecryptData(
        helper.parsePrivateKeyFromPem(pemPrivate), encrypted);
    print(decrypted);

    print(helper.sign(plainText, helper.parsePrivateKeyFromPem(pemPrivate)));
  });

  test('ttest', () async {
    RsaKeyHelper helper = RsaKeyHelper();
    String plainText = "hi";
    String pemPrivate = '''-----BEGIN RSA PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZM/kSGc3/ut5dCd65woQGeYKK+nGW/hWW7jhAwhX5cvEzW5qBvwx7HNuvSlbhYiyjKgnJXi/C20gnG73s+VMVfJybJmMgB0Nxo2Xf8S+A5kDozcWYYpAV3g9xx2tlwbs8tDeFNNne3VIU8NGOixy+6NX19C3BqVWRFJoujir88UQ6AAOrDatySSEkAD59ZbtxmcbC4VlJVXfSJ46e2i2AGvTQRiaq7IuLLqb/rBhOFtq853qV/cqoV2Xh6GvEGM/X2aEsxprwfs7J13rnVkO/jzZyXSyI05wCWs3SNlYfKhkgWES1CXKhYfKC/T2xdOmHufF6iiXzhq0y9sY/aaj/AgMBAAECggEAD2wy09e0OmPc9TNFtt/6evE21UJ6PVP2WXy5ztNZNxizysdG3c6ghr9iU/yN1bwgWkeaYUuITag/Y9OC9Wgwv5ZVEmkz4arSXafSDIg2LMtssXsm/C6Hd54Ib7ZOyG9sqZ9MT++URtBlSypcXug+1sl2o9u+QgGRm1cgqYybvdEMWao0UHDjqAG6EbKZHdHsXKlbBykxwzCKY085rAoP5l4M3KGQDPDJYWF4zTxAdgbORSqQy+O9PHhjhh3OHQbwyOMX3ZCoLTXEx1yHz13AhJIPUbu41cZA3I/QwhwVncy5DtVSlKyzbals9HvQ9p3XTvaNqAu13MPRdawABNCCaQKBgQD08Gq3HzvnC7XQ88L6GKCViGbjW9ma19LEJ3HzMFa6txpMuTUAVzHGdHrmZ3MWwMUAXqjQfvGEY5u2U696xPDNAsF9ZkoKEgHqcAARkzPPBcUt3UhVmrNBgdckpY6tF7rwJVf4Idi+dveF2O+JVtD1snlQHiH9xhtkku6+EYt5JwKBgQDjAuq0853UhmgRwOmhj8KUeyl/jdtTXkReWdXDTRShHATaOVD7R5u5qhaggtHm8DCU6qU1oZ9CtWtJGEIBe20d73q8SdPNXMybAycISuOcWCpdwLs/iU+2MLWKGLi6qrhAd7iDQeTdEy5YNGUKHzzkFS82W0JJNrTLnC7HFQ5IaQKBgAprf96ycXXuxZlSBWVmTs6NsvLRIXy42bqGgw55a/cdevzwlBSjoPZ0VhYfKII7SSYu4Led7uBW7HThMoHihuvxxhFznIq5IWO7yAT3YijYcf71fvJFVoLe5ywj7uHmNImqzQc9SV8w6G7FP8tz6gfJw+dooMGO//NTXNyxGmHZAoGABQB3c206uQgNGvcJLsogG21rSKgzgO6+yuVn1FnKbpJTeQtyQVcek0SwIvE+9rusFlvlL/1TqQCeUIn8SlQR32r7ZVKrHAdDatby8TfVNAitRkuM1KWN4BHKrjRFPbetP55jrmCxTj2x87eT0llF2jCtTaFNIJfX+/SBA1nvaqECgYEAmpBu7xLiBtDpH1fRT7pYMreoTufQKVbo9NelKQPg578KUn5QW+nCSeDIK2o5AFPmA5Tn07ZsQKIhlVgT9FkfaZKtVQRiNsMJbXEKTa8P1rgeuChIk2aB1fYlqkCIUVeLcNvaz79FmtbLcEIGpa/K6dgoWxHfE2kk5PAQSnlAiiA=
-----END RSA PRIVATE KEY-----''';
    String pemPublic = '''-----BEGIN RSA PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2TP5EhnN/7reXQneucKEBnmCivpxlv4Vlu44QMIV+XLxM1uagb8Mexzbr0pW4WIsoyoJyV4vwttIJxu97PlTFXycmyZjIAdDcaNl3/EvgOZA6M3FmGKQFd4PccdrZcG7PLQ3hTTZ3t1SFPDRjoscvujV9fQtwalVkRSaLo4q/PFEOgADqw2rckkhJAA+fWW7cZnGwuFZSVV30ieOntotgBr00EYmquyLiy6m/6wYThbavOd6lf3KqFdl4ehrxBjP19mhLMaa8H7Oydd651ZDv482cl0siNOcAlrN0jZWHyoZIFhEtQlyoWHygv09sXTph7nxeool84atMvbGP2mo/wIDAQAB
-----END RSA PUBLIC KEY-----''';
    RSAKeyPairClass keyPair = RSAKeyPairClass(
        helper.parsePrivateKeyFromPem(pemPrivate),
        helper.parsePublicKeyFromPem(pemPublic));
    String encrypted =
        CryptoClass.asymmetricEncryptData(keyPair.publicKey, plainText);
    print(encrypted.length);

    String decrypted =
        CryptoClass.asymmetricDecryptData(keyPair.privateKey, encrypted);
    print(decrypted);
  });
}
