import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_stories/data.dart';
import 'package:instagram_stories/screens/story_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Stories',
      home: StoryScreen(stories),
    );
  }
}
