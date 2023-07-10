import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:cryptofile/model/dto/addSubscribeDemandDTO.dart';
import 'package:cryptofile/model/dto/addWriteAuthorityDTO.dart';
import 'package:cryptofile/model/dto/allowSubscribeDTO.dart';
import 'package:cryptofile/model/dto/generateFileDTO.dart';
import 'package:cryptofile/model/dto/generateFolderDTO.dart';
import 'package:cryptofile/model/dto/modifyFileDTO.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptofile/model/dioHandling/dioHandling.dart';

void main() {
  String folderCP = "9APNuLSc8YMp7u3TYavRKZrHgRFY5ybXeVfx1pv5mD2B";
  String accountCP = "2mSLj32xhAEaw9EJgPsN7jQqyuU4hbrhFLxdGa43wN4s";
  String folderPublicKey = '''
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqTKHrhh/X1rH6RN759oWA/7xEGj9pJEqzpwawagCVlcK52U7RMocObxROK86ZU8Yk4kweyxPThnVS8JqKGTWcZALnGImviHqONfP8kZtAFqsdyg8tfPbRaHpVxhrkDh/6y5aXpETSmQA5TQllfg5dAPDlrA9AUOsZdgxvd2Pv3+aYmrdfFVr6J6BFjm6MLCutfsfV9/wAZB86/BxWbxqTEqGtUHhGQ5mDAIvP1Ym3xoEuDRWwlFZ48o4ZmVMB8PCYiBxHwCRJBxEBKRhIQ9BKXtdC3INGfRQgGDANlifBaKyZ2JN/dUzGaQx5LLpTqZK2lDoLrC+CSY0apt3Az3ZCQIDAQAB
''';
  String folderPrivateKey = '''
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/1JdlZM/+ouSAwIFlxtqNNBMJ1tMSAai9ab7ER9zD7i7hQ9GA2X+9OWlBd/cBMIBx0BQS5GsEQkCTgIfefnIGNy0NLcRFRhYKdi2cwLecs71B5w5rQQnTkw6l3Sk8Bn9Bp0WKCpwmGylw/k3wqUY2Rcrc6OZf0A3zw0kYdZMAnqFfRzrQVe9f0OtOvjaV/SiFVAViDZqd/aZV9hwdvxBPu+iNzQWKLW5T+/jWNfBuGqlUOYfkbmktXewPmG5rUfdQznV3EDKc/otValYdVz4TcGcyv/AsRs/VQBz/mhIhTlc8uJYVC991J2hBkvV+A9hpJT1aFr/f59JrXqeFZe8DAgMBAAECggEAcqraoOJlLnoiixAHiVYXuEZDhyMh4maZfjfir6OhRIFxBniqmBHrOKpDz72tKcnbTa0rAqwFiHMt9L3k+cutzydWR8VuyFX/wNsposTUPNh4Lhe218f13sHOBLmx906O7SjW+ZAkDOc5m3B4GH6nGLQZcnnJk8ZjQK4gWH2XlMsyu1Z0Q5uGDuik5G6OO4YcA54og90k/pg4+5SnjSCGkbq2cBKWpxPNP+pUvXNiC/lXn+hbQ2Ichi2SNwx4FywLswrk8gCQID5j+KGxMG74DDnVOOcmv7eRa8rPWCWlNWoTqfiy0XFXRhFdBdw0RpTZnd9i3CDAxc3v+tNfoaH3aQKBgQD89VBHXQHrSofVPYY8vOflZ/T4m/AwaduVF+hESPnV2+wk5ZMd/JySCbElnryppEdrzn17I6MtyqFOvSia8kmeHBZJkLgKqzTW08VlmUQR2bZYbj+6JIni7ZoRt/cSgAMoATstbwbm6rpVRgc0At1ipTDkPk3WSgkrPf5Ag8haZQKBgQDCIxtYhFpI9PdnGsUDBAivjFFRx/C5c980zKbhVzXt20gMg8m/96y1qI8pWLV1ZgyyXNVgpEsSjfNd7I/JaVx/ZrGLmISyPcVdVr7j6oGsOJB7AT7l8Nni+5QDgqBRJP5oKBKbEDwUnIlMGgXMZu5JJ4FbeIQQCfmd8EmCD20ZRwKBgFQ8XL9m+XyhFRqtokYXoiGCvNENHK8CkVzU2UPkCU5uLfUbfiI+POVk1NjyQ2E6k44S9TZMZ8qX75+I3jy68kj0kXdt+duTp8TiQJnUsBZBqbdI/2+9Oy2Wcff0ixJeDq8DufEnR+UdxW8gIsXvLknrOJzJIqJ5hRQhUMmrGM0BAoGAMign1IK9YMQJd1XvOIw+QjyadeqWQxOww09sfiOuBzn0L2eNJE+1C2n1MtV8bExlU1+wsTtBOhX6nnWT4JGcGD5L+Kj6/6H979ONlgzsW7ZxfZYgzf+gC4i8APwqt0w7fmV8CRv0qc6XmlXO0bR2M+hE/4DvfcVV/HwsQbICmdkCgYEAm41UMKqM6pf0/YSBv+Xvf8Q2Nhsb4bsut+a4trha+SuFFThWgR5nUWU+4Hr+xQPxdL4vSupYHq5ubPTwI7emfpdrELFCNCXA5dPClDnEa2C8prT6A/C4x55F3N3woNIZGKupnj7BZ6pzxutA8i2rSNquxngvcv/virYnXm/qtDE=
''';
  String accountPublicKey = '''
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv9SXZWTP/qLkgMCBZcbajTQTCdbTEgGovWm+xEfcw+4u4UPRgNl/vTlpQXf3ATCAcdAUEuRrBEJAk4CH3n5yBjctDS3ERUYWCnYtnMC3nLO9QecOa0EJ05MOpd0pPAZ/QadFigqcJhspcP5N8KlGNkXK3OjmX9AN88NJGHWTAJ6hX0c60FXvX9DrTr42lf0ohVQFYg2anf2mVfYcHb8QT7vojc0Fii1uU/v41jXwbhqpVDmH5G5pLV3sD5hua1H3UM51dxAynP6LVWpWHVc+E3BnMr/wLEbP1UAc/5oSIU5XPLiWFQvfdSdoQZL1fgPYaSU9Wha/3+fSa16nhWXvAwIDAQAB
''';
  String accountPrivateKey = '''
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/1JdlZM/+ouSAwIFlxtqNNBMJ1tMSAai9ab7ER9zD7i7hQ9GA2X+9OWlBd/cBMIBx0BQS5GsEQkCTgIfefnIGNy0NLcRFRhYKdi2cwLecs71B5w5rQQnTkw6l3Sk8Bn9Bp0WKCpwmGylw/k3wqUY2Rcrc6OZf0A3zw0kYdZMAnqFfRzrQVe9f0OtOvjaV/SiFVAViDZqd/aZV9hwdvxBPu+iNzQWKLW5T+/jWNfBuGqlUOYfkbmktXewPmG5rUfdQznV3EDKc/otValYdVz4TcGcyv/AsRs/VQBz/mhIhTlc8uJYVC991J2hBkvV+A9hpJT1aFr/f59JrXqeFZe8DAgMBAAECggEAcqraoOJlLnoiixAHiVYXuEZDhyMh4maZfjfir6OhRIFxBniqmBHrOKpDz72tKcnbTa0rAqwFiHMt9L3k+cutzydWR8VuyFX/wNsposTUPNh4Lhe218f13sHOBLmx906O7SjW+ZAkDOc5m3B4GH6nGLQZcnnJk8ZjQK4gWH2XlMsyu1Z0Q5uGDuik5G6OO4YcA54og90k/pg4+5SnjSCGkbq2cBKWpxPNP+pUvXNiC/lXn+hbQ2Ichi2SNwx4FywLswrk8gCQID5j+KGxMG74DDnVOOcmv7eRa8rPWCWlNWoTqfiy0XFXRhFdBdw0RpTZnd9i3CDAxc3v+tNfoaH3aQKBgQD89VBHXQHrSofVPYY8vOflZ/T4m/AwaduVF+hESPnV2+wk5ZMd/JySCbElnryppEdrzn17I6MtyqFOvSia8kmeHBZJkLgKqzTW08VlmUQR2bZYbj+6JIni7ZoRt/cSgAMoATstbwbm6rpVRgc0At1ipTDkPk3WSgkrPf5Ag8haZQKBgQDCIxtYhFpI9PdnGsUDBAivjFFRx/C5c980zKbhVzXt20gMg8m/96y1qI8pWLV1ZgyyXNVgpEsSjfNd7I/JaVx/ZrGLmISyPcVdVr7j6oGsOJB7AT7l8Nni+5QDgqBRJP5oKBKbEDwUnIlMGgXMZu5JJ4FbeIQQCfmd8EmCD20ZRwKBgFQ8XL9m+XyhFRqtokYXoiGCvNENHK8CkVzU2UPkCU5uLfUbfiI+POVk1NjyQ2E6k44S9TZMZ8qX75+I3jy68kj0kXdt+duTp8TiQJnUsBZBqbdI/2+9Oy2Wcff0ixJeDq8DufEnR+UdxW8gIsXvLknrOJzJIqJ5hRQhUMmrGM0BAoGAMign1IK9YMQJd1XvOIw+QjyadeqWQxOww09sfiOuBzn0L2eNJE+1C2n1MtV8bExlU1+wsTtBOhX6nnWT4JGcGD5L+Kj6/6H979ONlgzsW7ZxfZYgzf+gC4i8APwqt0w7fmV8CRv0qc6XmlXO0bR2M+hE/4DvfcVV/HwsQbICmdkCgYEAm41UMKqM6pf0/YSBv+Xvf8Q2Nhsb4bsut+a4trha+SuFFThWgR5nUWU+4Hr+xQPxdL4vSupYHq5ubPTwI7emfpdrELFCNCXA5dPClDnEa2C8prT6A/C4x55F3N3woNIZGKupnj7BZ6pzxutA8i2rSNquxngvcv/virYnXm/qtDE=
''';
  String folderPrivateKeyEWA =
      "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";
  String symmetricKeyEWF =
      "55zMTYJ3b6hmyheQwPA3S1iSH6C2gHYfan7s9XT3FqvxcKEFi3oAXpEHXMoxuZ8Vd9rRxpEjWp6naVFFtPSe62x4Ge2Wa9Gd3uZ7W9sH37zryB8fxRX2qLpr5pXLfzBVfh7GcQFtuWGswutywR2r6jDyneBUHmw9y8SdnFrNxR8RpVcFSWQcoiWnzmnMS8CuFXDKoXvgq6N52vtbxqCZzHRAB9n3Uv2cbDGBhpvMaf5PV9zYCL6HTGBcPbjghgXF58nbou9hqGRhHjbgPYmobxUw9HtXUMbbBPHC34yAvcyUoLM9Kaq3gNvS5wzaVgfCyHwJpNfRQ2usYLjUvxHviSRo32mVN3";
  List<int> accountSign = [
    48,
    140,
    88,
    34,
    96,
    25,
    22,
    150,
    200,
    244,
    64,
    208,
    51,
    208,
    187,
    249,
    28,
    159,
    190,
    45,
    177,
    102,
    144,
    6,
    195,
    105,
    143,
    29,
    71,
    210,
    199,
    210,
    84,
    85,
    68,
    160,
    89,
    182,
    27,
    14,
    216,
    44,
    242,
    62,
    194,
    210,
    86,
    107,
    234,
    61,
    82,
    159,
    125,
    240,
    5,
    106,
    91,
    231,
    224,
    90,
    252,
    192,
    220,
    146,
    71,
    111,
    34,
    190,
    151,
    220,
    11,
    103,
    154,
    187,
    21,
    170,
    196,
    144,
    195,
    146,
    106,
    178,
    172,
    122,
    20,
    188,
    217,
    38,
    22,
    113,
    255,
    88,
    65,
    197,
    116,
    96,
    193,
    140,
    110,
    188,
    33,
    46,
    87,
    114,
    125,
    59,
    70,
    93,
    86,
    190,
    48,
    15,
    106,
    134,
    139,
    121,
    254,
    209,
    242,
    192,
    16,
    60,
    8,
    53,
    0,
    140,
    162,
    158,
    24,
    59,
    169,
    218,
    252,
    133,
    214,
    116,
    179,
    227,
    96,
    48,
    188,
    28,
    222,
    130,
    65,
    13,
    87,
    21,
    169,
    4,
    223,
    96,
    200,
    246,
    161,
    203,
    89,
    143,
    167,
    116,
    100,
    35,
    37,
    135,
    212,
    228,
    146,
    2,
    80,
    15,
    100,
    114,
    145,
    241,
    200,
    101,
    154,
    192,
    16,
    191,
    204,
    72,
    24,
    254,
    13,
    55,
    93,
    94,
    11,
    77,
    230,
    8,
    243,
    48,
    234,
    192,
    48,
    120,
    215,
    128,
    132,
    217,
    7,
    252,
    168,
    98,
    43,
    14,
    224,
    16,
    185,
    136,
    249,
    213,
    200,
    205,
    168,
    49,
    69,
    27,
    38,
    16,
    125,
    76,
    48,
    68,
    174,
    136,
    52,
    188,
    24,
    174,
    96,
    193,
    163,
    34,
    190,
    179,
    93,
    125,
    40,
    37,
    26,
    16,
    187,
    246,
    152,
    92,
    164,
    226,
    57,
    21,
    77,
    247,
    81,
    16
  ];
  List<int> folderSign = [
    8,
    94,
    79,
    63,
    36,
    76,
    168,
    105,
    175,
    242,
    65,
    128,
    223,
    12,
    76,
    79,
    215,
    185,
    167,
    23,
    105,
    33,
    197,
    23,
    237,
    62,
    79,
    27,
    204,
    176,
    14,
    211,
    22,
    8,
    157,
    30,
    165,
    81,
    72,
    131,
    54,
    158,
    151,
    202,
    205,
    186,
    188,
    119,
    105,
    43,
    54,
    213,
    117,
    247,
    9,
    239,
    53,
    126,
    218,
    43,
    153,
    71,
    254,
    84,
    15,
    230,
    176,
    63,
    44,
    217,
    151,
    74,
    147,
    7,
    240,
    15,
    59,
    72,
    89,
    129,
    88,
    4,
    186,
    87,
    249,
    58,
    146,
    42,
    136,
    74,
    134,
    40,
    241,
    57,
    87,
    96,
    254,
    255,
    73,
    90,
    161,
    248,
    102,
    175,
    215,
    223,
    255,
    79,
    81,
    209,
    46,
    29,
    129,
    83,
    3,
    35,
    244,
    201,
    247,
    181,
    253,
    41,
    117,
    156,
    95,
    142,
    59,
    80,
    156,
    44,
    192,
    10,
    251,
    224,
    101,
    232,
    224,
    254,
    126,
    58,
    188,
    129,
    236,
    101,
    199,
    93,
    62,
    203,
    212,
    191,
    202,
    154,
    79,
    158,
    197,
    65,
    24,
    126,
    124,
    8,
    93,
    105,
    83,
    159,
    110,
    182,
    69,
    226,
    116,
    97,
    120,
    11,
    209,
    199,
    148,
    167,
    16,
    38,
    251,
    248,
    230,
    213,
    22,
    76,
    64,
    197,
    27,
    241,
    25,
    152,
    95,
    107,
    64,
    66,
    227,
    116,
    96,
    30,
    158,
    205,
    166,
    82,
    3,
    130,
    139,
    144,
    240,
    131,
    204,
    138,
    97,
    26,
    36,
    10,
    85,
    99,
    68,
    224,
    59,
    236,
    186,
    79,
    153,
    76,
    250,
    58,
    3,
    11,
    226,
    27,
    23,
    102,
    240,
    105,
    79,
    144,
    78,
    243,
    160,
    42,
    153,
    6,
    147,
    123,
    30,
    213,
    89,
    32,
    246,
    135,
    51,
    151,
    178,
    11,
    44,
    84
  ];
  test("singleton test", () {
    DioHandling _instance = DioHandling();
    DioHandling _instance2 = DioHandling();
    expect(_instance == _instance2, true);
  });

  test("dio server test", () async {
    final Dio dio = Dio();
    String baseUrl =
        "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'GET'),
    );
    print(res);
  });
  test("dio server test3", () async {
    final Dio dio = Dio();
    String baseUrl =
        "http://ec2-43-201-160-79.ap-northeast-2.compute.amazonaws.com:8080/api/v1/write-auths/fdsdfsa/folders";
    var res = await dio.request(
      baseUrl,
      options: Options(method: 'GET'),
    );
    print(res);
  });

  //generate finish
  test("dio generateFolder test", () async {
    DioHandling _instance = DioHandling();
    GenerateFolderDTO dto = GenerateFolderDTO(true, "hihi", symmetricKeyEWF);

    String str = await _instance.generateFolder(dto, folderCP);

    print("hi");
  });

  test("dio addWriteAuthority test", () async {
    DioHandling _instance = DioHandling();
    AddWriteAuthorityDTO dto = AddWriteAuthorityDTO(
        accountCP,
        folderCP,
        base58.encode(Uint8List.fromList(folderPublicKey.codeUnits)),
        folderPrivateKeyEWA);

    await _instance.addWriteAuthority(dto);

    print("hi");
  });

  test("dio getWriteAuthByAccountCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getWriteAuthByAccountCP(accountCP);
    print(res);
    // expect(res, false);
  });
  test("dio getReadAuthByAccountCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getReadAuthByAccountCP(accountCP);
    print(res);
    // expect(res.isEmpty, false);
  });

  test("dio getFileByFolderCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getFileByFolderCP(folderCP);
    print(res);
    // expect(res.isEmpty, false);
  });

  test("dio generateFile test", () async {
    DioHandling _instance = DioHandling();
    GenerateFileDTO dto = GenerateFileDTO(folderSign, "subhead");
    var res = await _instance.generateFile(folderPublicKey, dto);
    expect(res.isEmpty, false);
  });

  test("dio modifyFile test", () async {
    DioHandling _instance = DioHandling();
    ModifyFileDTO dto = ModifyFileDTO(folderSign, "contents", "subhead");
    var res = await _instance.modifyFile(dto, folderPublicKey, "fileId");
    expect(res.isEmpty, false);
  });

  test("dio addSubscribeDemand test", () async {
    DioHandling _instance = DioHandling();
    AddSubscribeDemandDTO dto =
        AddSubscribeDemandDTO("folderCP", "accountPublicKey", [1, 2, 3, 4]);
    var res = await _instance.addSubscribeDemand(dto);
  });

  test("dio allowSubscribe test", () async {
    DioHandling _instance = DioHandling();
    AllowSubscribeDTO dto = AllowSubscribeDTO("folderCP", [], "", "");
    var res = await _instance.allowSubscribe(dto);
  });

  test("dio getSubscribeDemands test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getSubscribeDemands("folderCP");
    expect(res.isEmpty, false);
  });

  test("dio search test", () async {
    String searchText = " ";
    DioHandling _instance = DioHandling();
    var res = await _instance.search(searchText);
    expect(res.isEmpty, false);
  });

  test("dio getContentsByFileIdAndFolderCP test", () async {
    DioHandling _instance = DioHandling();
    var res = await _instance.getContentsByFileIdAndFolderCP(
        "D82aA88htrCCgxL3yrJDh3mB2T9joVmbBf3sSooaNC3L", "dsfhksdfhkjs");
    print(res.contentsEWS);
    expect(res.contentsEWS.isEmpty, false);
  });
}
