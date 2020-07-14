import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_stories/models/story_model.dart';
import 'package:instagram_stories/widgets/animated_bar.dart';
import 'package:instagram_stories/widgets/user_info.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final List<Story> stories;

  StoryScreen(this.stories);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  VideoPlayerController _videoController;
  AnimationController _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this);

    final Story firtsStory = widget.stories.first;
    _loadStory(story: firtsStory, animatedToPage: false);

    _pageController = new PageController();
    _videoController = new VideoPlayerController.network(widget.stories[2].url)
      ..initialize().then((value) => setState(() {}));
    _videoController.play();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex++;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    this._animationController.dispose();
    _pageController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];

    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapDown: (details) => onTapDownStory(details, story),
          child: Stack(
            children: <Widget>[
              StoryPageView(
                  pageController: _pageController,
                  widget: widget,
                  videoController: _videoController),
              Positioned(
                top: 40.0,
                left: 10.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    Row(
                        children: widget.stories
                            .asMap()
                            .map((i, e) {
                              return MapEntry(
                                i,
                                AnimatedBar(
                                  animationController: _animationController,
                                  position: i,
                                  current: _currentIndex,
                                ),
                              );
                            })
                            .values
                            .toList()),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.5,
                        vertical: 10.0,
                      ),
                      child: UserInfo(story.user),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  onTapDownStory(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    print("Dx $dx");
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex--;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > screenWidth * 2 / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _loadStory(story: widget.stories[_currentIndex]);
      });
    } else {
      if (story.media == MediaType.video) {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
          _animationController.stop();
        } else {
          _videoController.play();
          _animationController.forward();
        }
      }
    }
  }

  void _loadStory({Story story, bool animatedToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    if (story.media == MediaType.image) {
      _animationController.duration = story.duration;
      _animationController.forward();
    } else if (story.media == MediaType.video) {
      _videoController = null;
      _videoController?.dispose();
      _videoController = new VideoPlayerController.network(story.url)
        ..initialize().then((_) {
          setState(() {
            if (_videoController.value.initialized) {
              _animationController.duration = _videoController.value.duration;
              _videoController.play();
              _animationController.forward();
            }
          });
        });
    }
    if (animatedToPage) {
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }
}

class StoryPageView extends StatelessWidget {
  const StoryPageView({
    Key key,
    @required PageController pageController,
    @required this.widget,
    @required VideoPlayerController videoController,
  })  : _pageController = pageController,
        _videoController = videoController,
        super(key: key);

  final PageController _pageController;
  final StoryScreen widget;
  final VideoPlayerController _videoController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.stories.length,
      itemBuilder: (context, i) {
        final Story story = widget.stories[i];

        if (story.media == MediaType.image) {
          return CachedNetworkImage(
            imageUrl: story.url,
            fit: BoxFit.cover,
          );
        } else if (story.media == MediaType.video) {
          if (_videoController != null && _videoController.value.initialized) {
            return FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
