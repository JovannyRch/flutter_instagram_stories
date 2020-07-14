import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final int current;

  AnimatedBar({this.animationController, this.position, this.current});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(children: <Widget>[
            _buildContainer(
              double.infinity,
              position < current ? Colors.white : Colors.white.withOpacity(0.5),
            ),
            position == current
                ? AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return _buildContainer(
                          constraints.maxWidth * animationController.value,
                          Colors.white);
                    },
                  )
                : SizedBox.shrink()
          ]);
        }),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      width: width,
      height: 5.0,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
