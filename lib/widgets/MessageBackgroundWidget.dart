import 'package:flutter/material.dart';

class MessageBackground extends StatefulWidget {
  const MessageBackground({Key? key}) : super(key: key);

  @override
  _MessageBackgroundState createState() => _MessageBackgroundState();
}

class _MessageBackgroundState extends State<MessageBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 6))
        ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInCirc,
  );
  @override
  void dispose() { 
    _animationController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment(0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF27B56E),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: BoxDecoration(
            color: Color(0xFFEFA7A6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(300),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFFF36E36),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(300),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.21, 0.50),
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFDC03A),
              borderRadius: BorderRadius.circular(30),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.97, -0.83),
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF27B56E),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.84, -1),
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFFDC03A),
                borderRadius: BorderRadius.circular(50),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
