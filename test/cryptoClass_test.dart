import 'dart:convert';
import 'package:cryptofile/model/crypto/RSAKeyPairClass.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptofile/model/crypto/cryptoClass.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

void main() {
  String accountPublicKeyPem = '''
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv9SXZWTP/qLkgMCBZcbajTQTCdbTEgGovWm+xEfcw+4u4UPRgNl/vTlpQXf3ATCAcdAUEuRrBEJAk4CH3n5yBjctDS3ERUYWCnYtnMC3nLO9QecOa0EJ05MOpd0pPAZ/QadFigqcJhspcP5N8KlGNkXK3OjmX9AN88NJGHWTAJ6hX0c60FXvX9DrTr42lf0ohVQFYg2anf2mVfYcHb8QT7vojc0Fii1uU/v41jXwbhqpVDmH5G5pLV3sD5hua1H3UM51dxAynP6LVWpWHVc+E3BnMr/wLEbP1UAc/5oSIU5XPLiWFQvfdSdoQZL1fgPYaSU9Wha/3+fSa16nhWXvAwIDAQAB
''';
  String accountPrivateKeyPem = '''
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/1JdlZM/+ouSAwIFlxtqNNBMJ1tMSAai9ab7ER9zD7i7hQ9GA2X+9OWlBd/cBMIBx0BQS5GsEQkCTgIfefnIGNy0NLcRFRhYKdi2cwLecs71B5w5rQQnTkw6l3Sk8Bn9Bp0WKCpwmGylw/k3wqUY2Rcrc6OZf0A3zw0kYdZMAnqFfRzrQVe9f0OtOvjaV/SiFVAViDZqd/aZV9hwdvxBPu+iNzQWKLW5T+/jWNfBuGqlUOYfkbmktXewPmG5rUfdQznV3EDKc/otValYdVz4TcGcyv/AsRs/VQBz/mhIhTlc8uJYVC991J2hBkvV+A9hpJT1aFr/f59JrXqeFZe8DAgMBAAECggEAcqraoOJlLnoiixAHiVYXuEZDhyMh4maZfjfir6OhRIFxBniqmBHrOKpDz72tKcnbTa0rAqwFiHMt9L3k+cutzydWR8VuyFX/wNsposTUPNh4Lhe218f13sHOBLmx906O7SjW+ZAkDOc5m3B4GH6nGLQZcnnJk8ZjQK4gWH2XlMsyu1Z0Q5uGDuik5G6OO4YcA54og90k/pg4+5SnjSCGkbq2cBKWpxPNP+pUvXNiC/lXn+hbQ2Ichi2SNwx4FywLswrk8gCQID5j+KGxMG74DDnVOOcmv7eRa8rPWCWlNWoTqfiy0XFXRhFdBdw0RpTZnd9i3CDAxc3v+tNfoaH3aQKBgQD89VBHXQHrSofVPYY8vOflZ/T4m/AwaduVF+hESPnV2+wk5ZMd/JySCbElnryppEdrzn17I6MtyqFOvSia8kmeHBZJkLgKqzTW08VlmUQR2bZYbj+6JIni7ZoRt/cSgAMoATstbwbm6rpVRgc0At1ipTDkPk3WSgkrPf5Ag8haZQKBgQDCIxtYhFpI9PdnGsUDBAivjFFRx/C5c980zKbhVzXt20gMg8m/96y1qI8pWLV1ZgyyXNVgpEsSjfNd7I/JaVx/ZrGLmISyPcVdVr7j6oGsOJB7AT7l8Nni+5QDgqBRJP5oKBKbEDwUnIlMGgXMZu5JJ4FbeIQQCfmd8EmCD20ZRwKBgFQ8XL9m+XyhFRqtokYXoiGCvNENHK8CkVzU2UPkCU5uLfUbfiI+POVk1NjyQ2E6k44S9TZMZ8qX75+I3jy68kj0kXdt+duTp8TiQJnUsBZBqbdI/2+9Oy2Wcff0ixJeDq8DufEnR+UdxW8gIsXvLknrOJzJIqJ5hRQhUMmrGM0BAoGAMign1IK9YMQJd1XvOIw+QjyadeqWQxOww09sfiOuBzn0L2eNJE+1C2n1MtV8bExlU1+wsTtBOhX6nnWT4JGcGD5L+Kj6/6H979ONlgzsW7ZxfZYgzf+gC4i8APwqt0w7fmV8CRv0qc6XmlXO0bR2M+hE/4DvfcVV/HwsQbICmdkCgYEAm41UMKqM6pf0/YSBv+Xvf8Q2Nhsb4bsut+a4trha+SuFFThWgR5nUWU+4Hr+xQPxdL4vSupYHq5ubPTwI7emfpdrELFCNCXA5dPClDnEa2C8prT6A/C4x55F3N3woNIZGKupnj7BZ6pzxutA8i2rSNquxngvcv/virYnXm/qtDE=
''';
  String publicKeyPem = '''
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqTKHrhh/X1rH6RN759oWA/7xEGj9pJEqzpwawagCVlcK52U7RMocObxROK86ZU8Yk4kweyxPThnVS8JqKGTWcZALnGImviHqONfP8kZtAFqsdyg8tfPbRaHpVxhrkDh/6y5aXpETSmQA5TQllfg5dAPDlrA9AUOsZdgxvd2Pv3+aYmrdfFVr6J6BFjm6MLCutfsfV9/wAZB86/BxWbxqTEqGtUHhGQ5mDAIvP1Ym3xoEuDRWwlFZ48o4ZmVMB8PCYiBxHwCRJBxEBKRhIQ9BKXtdC3INGfRQgGDANlifBaKyZ2JN/dUzGaQx5LLpTqZK2lDoLrC+CSY0apt3Az3ZCQIDAQAB
''';
  String privateKeyPem = '''
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpMoeuGH9fWsfpE3vn2hYD/vEQaP2kkSrOnBrBqAJWVwrnZTtEyhw5vFE4rzplTxiTiTB7LE9OGdVLwmooZNZxkAucYia+Ieo418/yRm0AWqx3KDy189tFoelXGGuQOH/rLlpekRNKZADlNCWV+Dl0A8OWsD0BQ6xl2DG93Y+/f5piat18VWvonoEWObowsK61+x9X3/ABkHzr8HFZvGpMSoa1QeEZDmYMAi8/VibfGgS4NFbCUVnjyjhmZUwHw8JiIHEfAJEkHEQEpGEhD0Epe10Lcg0Z9FCAYMA2WJ8ForJnYk391TMZpDHksulOpkraUOgusL4JJjRqm3cDPdkJAgMBAAECggEAdOhQLbAJmnZceSSYUawz2BD4uhEBaQtRG69rIXIYI1ZDV31wBWjtNct0B4mz/Lo5Tf/V+tWz+lAJPC6aMUzzi0Yvb5+2C1vdvecIbOvSdxMv5alswYA8exGT7DUYZW9Um8jMclkljhopMDXm3ofEEvBi3aTqkgwTe891Fy6XG4ZLVsY6R9avcOYgjMpjPQ4lK++Zwe+ltEPXqQekAPuI9xBios0zSyzmo70o2f2VKU5XNrKSMUcV4DNzVVrw4rEG3YDEfir+pk2bxlS8AFl5E3viG2W1oGsa1UskOJmq2GIXsKE7GWK7umCvMjjTEBKgAB0H6nM/jGg07ZHpPKCBvQKBgQDo2nlugrK7AKb+0DwFv/AT7sBj29BV19r/vWgxZtGfP+F3BfRyxN+6sdaHJsXlL8/DW7PJdsZP24OanbdYMgKPXTfuXroJ4Q6zEmwKRMtS9wdufkbaO3tGkfPz1WJFyG0A7X0Uonj45vk7f++MCmvwnlCVIWFJnYVa1JdnQ8cxvwKBgQC6BCwEycTXXMowb6mA/4w8iWONGgNKkIAdw/cT3ca7F2SRjVl18olq8K4wVbgFcvXhyp55xPJqS7OKswgFIuI2LSgK/zBP0WcL+AAkrN7qDDsbWM2NEqvsTMpl0UFQoPgGuXB5D5KVYUQUb5sq4QCabfLEfqiopGlsOTYsfIYXNwKBgQC85i/ItQKlrfvLj8aBq5npsbAl0ncKjNg+y7sxCIZZuIsB8bTDPm95lze/4HZ+XPEhPM13TIHI2v3Cetv4Emn9P9RV7kbiKM+x+enn0rNXlMtUmeCEvehd8Z2EW8Ejd1rme8MS8FNPKKFb4YfFhdbXFreso622+LDsZLaGsXdxJQKBgGuvxpvvAtl6ikKIIiTfzBuvncYt7QHZrZGNxRfnKAlffYUVw1iY1BzowK6SsTnWV6ojVqM/9Oa8dHAzPM1caIDcm3XiTeGnZHR1Wf/hZBsygXVPb4/f40+lFPbksV8wEOYzrH0pGr8H1BXQlo+4OlUsmYJPoOwgYjeY11fhru75AoGBAJDsqhI7imLoSz0dV7o72fI8zy760txu5a0/Iy1HKJ0AJaY675/yJLAO9V0IYkh6pCPjTDou42avGZGbIaGRlNimG5E9QgQWAGWyenCfANEYXRPxlOhgKMoAvQ4lU+OkMigspfdIIdYaEM1KwRDeJAO/TCnCdzeNe5bA9NCYhuRf
''';
  test('asymmetric encrypt data test', () async {
    String longText = "dfs";
    print(longText.length);
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    String encrypted =
        CryptoClass.asymmetricEncryptData(keyPair.publicKey, longText);
    String decrypted =
        CryptoClass.asymmetricDecryptData(keyPair.privateKey, encrypted);
    expect(longText, decrypted);
  });

  test('get pem test', () async {
    RSAKeyPairClass keyPair = await RSAKeyPairClass.createKeyPair();
    print(keyPair.getPrivateKeyString());
    print(keyPair.getPublicKeyString());
  });

  test('get compressed publickey test', () async {
    RSAKeyPairClass keyPair =
        RSAKeyPairClass.fromPems(publicKeyPem, privateKeyPem);
    print(keyPair.getCompressedPublicKeyString());
    expect(keyPair.getCompressedPublicKeyString().length, 44);
  });

  test('is keypair valid test', () async {
    RSAKeyPairClass keyPair =
        RSAKeyPairClass.fromPems(publicKeyPem, privateKeyPem);
    expect(keyPair.isKeyPairValid(), true);
  });

  test('encrypt test', () async {
    String encrypted = CryptoClass.asymmetricEncryptDataFromPem(
        accountPublicKeyPem, publicKeyPem);
    print(encrypted);
    expect(encrypted.isEmpty, false);
  });

  test('decrypt test', () async {
    String encrypted =
        "2Ajb8omN1L7rVC8J6WedZU1G1fo6Mr99trxsxu8wsekTzMmqrnbbfw1nB1C7TzKso4cBQWGpTT6LL3vsmojcRmvmzeipzy3crm1F3g8v5ZyMA1rzHbUkbCcTLhEcDc8ttdRFLtb4fxTxbXd6ueRnBYU55GuF6JiNZsQkHCFXVGxkQdRAGhkWZxWM6hSw4HSjixArxo3EdokZ5Y874WkeMeb3aVdi4iMwGHd6bLBTQUG1k8EGek2k27adBqND5Fh6AkYxF8rtuBHbZk4sQ6Ea9GqzVxcMUu8zqbzL7VtRcJqdcGH3VXMfnp7b2n3WLq2PFdCqexWofcJamr7yevAJcy9CZbX7wtBucGoEE4TSxS5fwtohLVL5PC5kuUtdBBj6kfntZK3yoWuLa2v7VDqGDLMHeYJ7i2biWCbpmWewTT3U4CCfg8kRFDANrQnVuwMJoTpdPNGK2SEGL3b111y1RW2Bm6spEHvUA7QiPXYug2CfghJjStbyBT1xqc3DqwjxekgHeTyW6X7dzkTk1e7pwzgb6EpdqzWb7EbXetqf1HtURhbDCfc5qWCxzNoAMb4F1E6hbf4UmuHWXANuhWtv6aJ9rwfKxEchw6HbLqYS1c8NWp3PQHroCQYo3cQjkV46x4X24dDJC9y9Fn3zVZo5wycwdJqUJwsUFhHzfGnTCsQc17a92tMZj8uVjrJS";
    String decrypted = CryptoClass.asymmetricDecryptDataFromPem(
        accountPrivateKeyPem, encrypted);
    print(decrypted);
  });

  test("encrypt and decrypt", () {
    String text = "hi동욱我是中国人";
    String encrypted =
        CryptoClass.asymmetricEncryptDataFromPem(publicKeyPem, text);
    print(encrypted);
    String decrypted =
        CryptoClass.asymmetricDecryptDataFromPem(privateKeyPem, encrypted);
    print(decrypted);
    expect(decrypted, text);
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
