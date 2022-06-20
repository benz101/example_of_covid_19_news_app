import 'package:example_of_covid_19_news_app/ui/news_page.dart';
import 'package:example_of_covid_19_news_app/ui/report_page.dart';
import 'package:example_of_covid_19_news_app/ui/video_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  int _selectedNavBar = 0;

  final List<Widget> _listPage = [
    const NewsPage(),
    const ReportPage(),
    const VideoPage()
  ];

  void _changeSelect(int index) {
    setState(() {
      _selectedNavBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apps News'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: _listPage[_selectedNavBar],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play_outlined),
            label: 'Video',
          )
        ],
        currentIndex: _selectedNavBar,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelect,
      ),
    );
  }
}
