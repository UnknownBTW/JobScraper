import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main () {
  runApp(JobScraper());
}

class JobScraper extends StatefulWidget {
  const JobScraper({super.key});

  @override
  State<JobScraper> createState() => _JobScraperState();
}

class _JobScraperState extends State<JobScraper> {
  @override
  Widget build(BuildContext context){
    const appTitle = 'JobScraper';
    return const MaterialApp(
      title: appTitle,
      home: Scaffold(
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
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
        child: SizedBox(
          width: 450,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
            ),
          ),
        )
        ),
      ],
    );
  }
}