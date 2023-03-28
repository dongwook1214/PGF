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
    print(encrypted.codeUnits);
    expect(encrypted.isEmpty, false);
  });

  test('decrypt test', () async {
    String encrypted = String.fromCharCodes([
      123,
      219,
      198,
      9,
      170,
      254,
      200,
      2,
      17,
      98,
      118,
      35,
      145,
      132,
      78,
      242,
      9,
      38,
      45,
      103,
      131,
      27,
      54,
      10,
      210,
      117,
      90,
      108,
      227,
      126,
      70,
      223,
      113,
      236,
      64,
      199,
      200,
      44,
      218,
      36,
      146,
      2,
      183,
      86,
      50,
      246,
      103,
      200,
      20,
      243,
      155,
      198,
      194,
      20,
      186,
      249,
      65,
      69,
      43,
      246,
      125,
      217,
      22,
      59,
      38,
      55,
      96,
      200,
      84,
      172,
      25,
      251,
      71,
      5,
      11,
      227,
      208,
      185,
      44,
      205,
      10,
      177,
      64,
      14,
      56,
      46,
      191,
      29,
      167,
      74,
      163,
      197,
      172,
      78,
      89,
      39,
      1,
      128,
      185,
      44,
      29,
      234,
      56,
      69,
      214,
      4,
      74,
      66,
      153,
      159,
      54,
      28,
      117,
      252,
      136,
      175,
      152,
      1,
      254,
      80,
      15,
      8,
      27,
      173,
      254,
      16,
      245,
      243,
      50,
      0,
      100,
      136,
      104,
      0,
      192,
      179,
      153,
      221,
      75,
      13,
      45,
      95,
      17,
      80,
      111,
      139,
      95,
      224,
      167,
      37,
      210,
      206,
      15,
      37,
      244,
      155,
      172,
      64,
      239,
      252,
      74,
      197,
      161,
      242,
      63,
      206,
      39,
      11,
      189,
      119,
      176,
      137,
      91,
      245,
      188,
      206,
      175,
      82,
      164,
      160,
      43,
      165,
      168,
      103,
      163,
      129,
      245,
      24,
      243,
      161,
      103,
      247,
      45,
      148,
      21,
      59,
      141,
      169,
      42,
      228,
      150,
      73,
      234,
      153,
      82,
      161,
      209,
      198,
      191,
      5,
      144,
      231,
      254,
      127,
      19,
      119,
      125,
      57,
      90,
      67,
      54,
      6,
      6,
      191,
      92,
      69,
      163,
      183,
      75,
      133,
      166,
      233,
      235,
      254,
      195,
      254,
      233,
      126,
      226,
      151,
      7,
      41,
      3,
      184,
      223,
      192,
      157,
      171,
      93,
      244,
      157,
      175,
      138,
      19,
      110,
      22,
      110,
      116,
      194,
      122,
      34,
      5,
      31,
      57,
      200,
      254,
      125,
      188,
      97,
      166,
      242,
      193,
      76,
      187,
      227,
      1,
      12,
      244,
      207,
      172,
      138,
      108,
      14,
      254,
      180,
      108,
      114,
      182,
      93,
      12,
      232,
      30,
      46,
      138,
      238,
      253,
      16,
      100,
      153,
      148,
      170,
      251,
      143,
      139,
      64,
      236,
      192,
      254,
      132,
      9,
      107,
      133,
      63,
      8,
      93,
      203,
      124,
      104,
      20,
      107,
      206,
      90,
      10,
      248,
      162,
      162,
      33,
      230,
      84,
      224,
      77,
      219,
      36,
      112,
      13,
      101,
      205,
      41,
      238,
      103,
      241,
      18,
      183,
      203,
      162,
      102,
      65,
      208,
      212,
      251,
      156,
      255,
      146,
      91,
      34,
      128,
      90,
      119,
      18,
      218,
      35,
      15,
      250,
      186,
      61,
      244,
      164,
      43,
      248,
      240,
      185,
      77,
      197,
      210,
      60,
      250,
      58,
      120,
      165,
      250,
      178,
      4,
      118,
      238,
      102,
      11,
      32,
      250,
      150,
      144,
      27,
      1,
      251,
      173,
      72,
      221,
      75,
      73,
      246,
      111,
      247,
      104,
      86,
      169,
      224,
      66,
      248,
      57,
      154,
      142,
      81,
      142,
      121,
      53,
      9,
      217,
      230,
      166,
      211,
      147,
      195,
      133,
      157,
      121,
      42,
      178,
      201,
      242,
      240,
      229,
      117,
      56,
      49,
      176,
      33,
      178,
      221,
      216,
      238,
      180,
      120,
      198,
      149,
      252,
      112,
      0,
      16,
      195,
      131,
      158,
      226,
      39,
      241,
      174,
      6,
      118,
      166,
      23,
      32,
      207,
      35,
      90,
      115,
      193,
      92,
      97,
      62,
      195,
      244,
      234,
      43,
      72,
      205,
      248,
      139,
      82,
      119,
      214,
      142,
      91,
      169,
      150,
      244,
      139,
      120,
      230,
      159,
      10,
      128,
      244,
      137,
      137,
      103,
      37,
      126,
      154,
      108,
      7,
      74,
      65,
      172,
      81,
      227,
      98,
      140,
      149,
      205,
      255,
      205,
      67,
      133,
      103
    ]);

    String decrypted = CryptoClass.asymmetricDecryptDataFromPem(
        accountPrivateKeyPem, encrypted);
    print(decrypted);
  });

  test("encrypt and decrypt", () {
    String text = "hi동욱我是中国人";
    String encrypted =
        CryptoClass.asymmetricEncryptDataFromPem(publicKeyPem, text);
    String decrypted =
        CryptoClass.asymmetricDecryptDataFromPem(privateKeyPem, encrypted);
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
