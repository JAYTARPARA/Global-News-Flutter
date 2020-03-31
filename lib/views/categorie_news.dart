import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:globalnews/helper/news.dart';
import 'package:globalnews/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Global",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "News",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        actions: <Widget>[
          // Opacity(
          //   opacity: 0,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     child: Icon(
          //       Icons.share,
          //     ),
          //   ),
          // ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              // child: CircularProgressIndicator(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitWave(
                    color: Colors.black,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Loading ' + widget.newsCategory + ' news...',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newslist[index].urlToImage ?? "",
                          title: newslist[index].title ?? "",
                          desc: newslist[index].description ?? "",
                          content: newslist[index].content ?? "",
                          posturl: newslist[index].articleUrl ?? "",
                        );
                      }),
                ),
              ),
            ),
    );
  }
}
