import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
    Report({
        this.dataProvider,
    });

    List<DataProvider>? dataProvider;

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        dataProvider: List<DataProvider>.from(json["dataProvider"].map((x) => DataProvider.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dataProvider": List<dynamic>.from(dataProvider!.map((x) => x.toJson())),
    };
}

class DataProvider {
    DataProvider({
        this.usStatePostal,
        this.cntTestedPos,
        this.cntTested,
    });

    String? usStatePostal;
    int? cntTestedPos;
    int? cntTested;

    factory DataProvider.fromJson(Map<String, dynamic> json) => DataProvider(
        usStatePostal: json["us_state_postal"],
        cntTestedPos: json["cnt_tested_pos"],
        cntTested: json["cnt_tested"],
    );

    Map<String, dynamic> toJson() => {
        "us_state_postal": usStatePostal,
        "cnt_tested_pos": cntTestedPos,
        "cnt_tested": cntTested,
    };
}
