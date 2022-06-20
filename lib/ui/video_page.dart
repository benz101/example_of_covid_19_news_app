import 'package:example_of_covid_19_news_app/model/latest_video.dart';
import 'package:example_of_covid_19_news_app/service/api_service.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({ Key? key }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final APIService _apiService = APIService();

  void _getListVideoProcess(){
    _apiService.getListVideo().then((value){
      if (value.kind == 'youtube#searchListResponse') {
        // ignore: avoid_print
        print(latestVideoToJson(value));
      } else {
        // ignore: avoid_print
        print(latestVideoToJson(value));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getListVideoProcess();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: const Text('Video Page'),
    );
  }
}