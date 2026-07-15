import 'package:flutter/material.dart';
import 'package:news_app/data/api/api.dart';
import 'package:news_app/data/models/news_models.dart';
import 'package:news_app/widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "status": "ok",
    "totalResults": 5588,
    "articles": [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 12, 24),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 46, 94),
        title: Text(
          'News App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<NewsModel>(
        future: Api.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error:Please try again later',
                style: TextStyle(
                  color: const Color.fromARGB(255, 170, 37, 37),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (snapshot.hasData) {
            List<Articles> articles = snapshot.data!.articles ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return ImageItemWidget(
                  image: articles[index].urlToImage ?? dummyImage,
                  title: articles[index].title ?? '',
                  onTap: () {},
                );
              },
              itemCount: articles.length,
            );
          } else {
            return Center(
              child: Container(
                color: Color.fromARGB(255, 88, 3, 3),
                child: Text(
                  'No data available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
