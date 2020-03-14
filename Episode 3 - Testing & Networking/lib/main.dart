import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'src/article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _ids = [
    22547283,
    22552477,
    22562041,
    22564665,
    22551856,
    22554527,
    22548217,
    22567240,
    22548708,
    22556156,
    22570909,
    22558422,
    22567937,
    22570684,
    22566238,
    22557491,
    22548750,
    22561291,
    22557065,
    22546931,
    22556681,
    22547469,
    22552730,
    22555490,
  ];

  Future<Article> _getArticle(int id) async {
    final storyUrl = "https://hacker-news.firebaseio.com/v0/item/$id.json";
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _ids
            .map((id) => FutureBuilder<Article>(
                future: _getArticle(id),
                builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _buildItem(snapshot.data);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }))
            .toList(),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(14.0),
      child: ExpansionTile(
        title: Text(article.title, style: TextStyle(fontSize: 22.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${article.type}"),
              IconButton(
                icon: Icon(Icons.launch),
                color: Colors.blue,
                onPressed: () async {
                  final articleUrl = article.url;
                  if (await canLaunch(articleUrl)) {
                    launch(articleUrl);
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
