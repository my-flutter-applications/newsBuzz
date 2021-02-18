import 'package:flutter/material.dart';
import 'package:news_bizz/helper/news.dart';
import 'package:news_bizz/models/article_model.dart';
import 'package:news_bizz/views/article_view.dart';

class CategoryViews extends StatefulWidget {
  final String category;
  CategoryViews({this.category});
  @override
  _CategoryViewsState createState() => _CategoryViewsState();
}

class _CategoryViewsState extends State<CategoryViews> {
  List<Article> articles = new List<Article>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  void getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('News'),
            Text(
              'Buzz',
              style: TextStyle(color: Colors.yellow[700]),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: articles.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desc: articles[index].desc,
                            url: articles[index].articleUrl,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imageUrl)),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
