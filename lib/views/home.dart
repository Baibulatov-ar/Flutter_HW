import 'package:flutter/material.dart';

import '../helper/data.dart';
import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
import 'article_view.dart';
import 'category_news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<CategoryModel> categories;
  late final List<ArticleModel> articles;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsTable = News();
    await newsTable.getNews();

    articles = newsTable.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Main"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    ///Categories
                    SizedBox(
                      height: 64,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              )),
                    ),

                    ///Blogs
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) => BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String? imageUrl, categoryName;

  const CategoryTile({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryNews(category: categoryName!.toLowerCase())));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                imageUrl!,
                width: 116,
                height: 64,
                fit: BoxFit.cover,
              )),
          Container(
            alignment: Alignment.center,
            width: 116,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryName!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, desc, url;
  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl!),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc!,
              style: const TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
