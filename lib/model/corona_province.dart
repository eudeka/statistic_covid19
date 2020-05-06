// TODO 04 : generate JSON to Dart (https://app.quicktype.io/)

import 'dart:convert';

class CoronaProvince {
  List<Datum> listData;

  CoronaProvince({
    this.listData,
  });

  factory CoronaProvince.fromJson(String str) {
    return CoronaProvince.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory CoronaProvince.fromMap(Map<String, dynamic> json) {
    return CoronaProvince(
      listData: json["data"] == null
          ? null
          : List<Datum>.from(json["data"].map((x) {
              return Datum.fromMap(x);
            })),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "data": listData == null
          ? null
          : List<dynamic>.from(listData.map((x) {
              return x.toMap();
            })),
    };
  }
}

class Datum {
  int fId;
  int provinceCode;
  String province;
  int positiveCases;
  int curedCases;
  int deathCases;

  Datum({
    this.fId,
    this.provinceCode,
    this.province,
    this.positiveCases,
    this.curedCases,
    this.deathCases,
  });

  factory Datum.fromJson(String str) {
    return Datum.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Datum.fromMap(Map<String, dynamic> json) {
    return Datum(
      fId: json["fid"] == null ? null : json["fid"],
      provinceCode: json["kodeProvi"] == null ? null : json["kodeProvi"],
      province: json["provinsi"] == null ? null : json["provinsi"],
      positiveCases: json["kasusPosi"] == null ? null : json["kasusPosi"],
      curedCases: json["kasusSemb"] == null ? null : json["kasusSemb"],
      deathCases: json["kasusMeni"] == null ? null : json["kasusMeni"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fid": fId == null ? null : fId,
      "kodeProvi": provinceCode == null ? null : provinceCode,
      "provinsi": province == null ? null : province,
      "kasusPosi": positiveCases == null ? null : positiveCases,
      "kasusSemb": curedCases == null ? null : curedCases,
      "kasusMeni": deathCases == null ? null : deathCases,
    };
  }
}
