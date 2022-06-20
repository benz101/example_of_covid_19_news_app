import 'package:example_of_covid_19_news_app/model/news.dart';
import 'package:example_of_covid_19_news_app/service/api_service.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({ Key? key }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final APIService _apiService = APIService();

  void _getListNewsProcess(){
    _apiService.getListNews().then((value){
      if (value.status == 'ok') {
        // ignore: avoid_print
        print(newsToJson(value));
      } else {
        // ignore: avoid_print
        print(newsToJson(value));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getListNewsProcess();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: const Text('News Page'),
    );
  }
}