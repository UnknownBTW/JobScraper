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
    const appTitle = 'JobScraper';
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
                      _navigateToNextScreen(context);
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
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResult()));
  }
}

class SearchResult extends StatelessWidget{
  @override
  Widget build( BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Screen'),),
    );
  }
}