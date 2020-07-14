import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_stories/data.dart';
import 'package:instagram_stories/models/user_model.dart';

class UserInfo extends StatelessWidget {
  final User user;
  UserInfo(this.user);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      CircleAvatar(
        radius: 20.0,
        backgroundColor: Colors.grey[300],
        backgroundImage: CachedNetworkImageProvider(this.user.profileImageUrl),
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      IconButton(
        icon: Icon(
          Icons.close,
          size: 30.0,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      )
    ]);
  }
}
