import 'dart:convert';

import 'package:example_of_covid_19_news_app/helper/api_key.dart';
import 'package:example_of_covid_19_news_app/helper/url_helper.dart';
import 'package:example_of_covid_19_news_app/model/latest_video.dart';
import 'package:example_of_covid_19_news_app/model/news.dart';
import 'package:example_of_covid_19_news_app/model/report.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<News> getListNews() async {
    Map<String, dynamic> queryParameters = {
      "q": "COVID",
      "apiKey": APIKey.apiKeyNews,
      "sortBy": "publishedAt",
      "language": "en"
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Accept": "*/*"
    };

    try {
      Uri uri = Uri.parse(URLHelper.urlNews)
          .replace(queryParameters: queryParameters);
      final result = await http.get(uri, headers: header);

      if (result.statusCode == 200) {
        // ignore: avoid_print
        print('ok from getListNews');
        return News.fromJson(jsonDecode(result.body));
      } else {
        // ignore: avoid_print
        print('bad from getListNews');
        News badResponse = News.fromJson(jsonDecode(result.body));
        return News(
            status: badResponse.status,
            totalResults: badResponse.totalResults,
            articles: []);
      }
    } catch (e) {
      // ignore: avoid_print
      print('error from getListNews');
      return News(status: e.toString(), totalResults: 0, articles: []);
    }
  }

  Future<Report> getListReport(String date) async {
    Map<String, dynamic> queryParameters = {
      "where": "(date_stamp=$date)",
      "cols": "us_state_postal,cnt_tested_pos,cnt_tested",
      "format": "amcharts",
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Accept": "*/*"
    };

    try {
      Uri uri = Uri.parse(URLHelper.urlReport)
          .replace(queryParameters: queryParameters);
      final result = await http.get(uri, headers: header);

      if (result.statusCode == 200) {
        // ignore: avoid_print
        print('ok from getListReport');
        return Report.fromJson(jsonDecode(result.body));
      } else {
        // ignore: avoid_print
        print('bad from getListReport');
        return Report(dataProvider: null);
      }
    } catch (e) {
      // ignore: avoid_print
      print('error from getListReport');
      return Report(dataProvider: null);
    }
  }

  Future<LatestVideo> getListVideo() async {
    Map<String, dynamic> queryParameters = {
      "part": "snippet",
      "maxResults": "25",
      "q": "covid+news+in+united+states",
      "key": APIKey.apiKeyVideo,
      "order": "date"
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Accept": "*/*"
    };

    try {
      Uri uri = Uri.parse(URLHelper.urlVideo)
          .replace(queryParameters: queryParameters);
      final result = await http.get(uri, headers: header);

      if (result.statusCode == 200) {
        // ignore: avoid_print
        print('ok from getListVideo');
        return LatestVideo.fromJson(jsonDecode(result.body));
      } else {
        // ignore: avoid_print
        print('bad from getListVideo');
        return LatestVideo(
            kind: '',
            etag: '',
            nextPageToken: '',
            regionCode: '',
            pageInfo: null,
            items: []);
      }
    } catch (e) {
      // ignore: avoid_print
      print('error from getListVideo');
      return LatestVideo(
          kind: '',
          etag: '',
          nextPageToken: '',
          regionCode: '',
          pageInfo: null,
          items: []);
    }
  }
}
