import 'package:flutter/material.dart';
import 'package:instagram_stories/models/user_model.dart';

enum MediaType { video, image }

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;

  Story({
    @required this.url,
    @required this.media,
    @required this.duration,
    @required this.user,
  });
}
