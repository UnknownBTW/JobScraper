import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main () {
  runApp(const JobScraper());
}

class JobScraper extends StatefulWidget {
  const JobScraper({super.key});

  @override
  State<JobScraper> createState() => _JobScraperState();
}

class _JobScraperState extends State<JobScraper> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
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
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Text(
                  'JobScraper',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 1000,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 180, vertical: 16),
                  child: TextField(
                    controller: TextEditingController()..text = value,
                    onSubmitted: (String value) {
                      print(value);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult(value)));
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}