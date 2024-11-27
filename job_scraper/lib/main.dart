import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

void main () {
  runApp(const JobScraper());
  
}

class Article {
  final String url;
  final String title;
  
  const Article({
    required this.url,
    required this.title,
  });
}

class JobScraper extends StatefulWidget {
  const JobScraper({super.key});

  @override
  State<JobScraper> createState() => _JobScraperState();
}

List<Article> articles1 = [];
List<Article> articles2 = [];
List<Article> allArticles = articles1 + articles2;
class _JobScraperState extends State<JobScraper> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Future getWbesiteData(value) async {
    final newValue = value.split(' ');
    String finalValue = "";
    for (final x in newValue){
      finalValue += x + '+';
    }
    final url = Uri.parse('https://uk.indeed.com/jobs/' + finalValue);
    final url2 = Uri.parse('https://www.reed.co.uk/jobs/' + finalValue);
    final response = await http.get(url);
    final response2 = await http.get(url2);
    dom.Document html = dom.Document.html(response.body);
    dom.Document html2 = dom.Document.html(response2.body);
    
    final titles = html.querySelectorAll('h2 > a > span').map((element) => element.innerHtml.trim()).toList();
    final titles2 = html2.querySelectorAll('article > div > button').map((element) => element.innerHtml.trim()).toList();

    final urls = html.querySelectorAll('h2 > a').map((element) => 'https://uk.indeed.com${element.attributes['href']}').toList();
    final urls2 = html.querySelectorAll('h2 > a').map((element) => 'https://www.reed.co.uk${element.attributes['href']}').toList();
    
    setState((){
      articles1 = List.generate(
        titles.length,
        (index) =>Article(
          title: titles[index],
          url: urls[index], 
        ),
      );
      articles2 = List.generate(
        titles.length,
        (index) =>Article(
          title: titles2[index],
          url: urls2[index], 
        ),
      );
    });
    allArticles = articles1 + articles2;
    print(allArticles.length);
  }
  Widget build(BuildContext context){
    String appTitle = 'JobScraper';
    return MaterialApp(
      title: appTitle,
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  child: Text(
                    'JobScraper',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 700,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: myController,
                      onSubmitted: (String value) {
                        print(value);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult(value)));
                        getWbesiteData(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    )
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget{
  final String value;
  final myController = TextEditingController();

  SearchResult(this.value);
  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      title: value,
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            toolbarOpacity: 1,
            backgroundColor: Colors.white,
            title: Stack(
              children:[
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Text(
                    'JobScraper',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1000,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                    child: TextField(
                      controller: TextEditingController()..text = value,
                      onSubmitted: (String value) {
                        print(value);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult(value)));
                        //getWbesiteData(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    )
                  )
                ),
              ]
            ), 
          ),
          body: Stack(
            children: [
            SelectionArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(80),
                itemCount: allArticles.length,
                itemBuilder: (context, index) {
                  final article = allArticles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.url),
                  );
                }
              ),
            ),

          ],
        ),
      ),
    )
  );
  }
}