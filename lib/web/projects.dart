import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/information.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;
  late Animation<Offset> _textOffsetAnimation;
  late Animation<Offset> _imageOffsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _textOffsetAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _imageOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('projects-visibility-detector'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.1) {
          _textController.forward();
          _imageController.forward();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/abstarct.png'), // Replace with your image path
            fit: BoxFit.fitWidth,
          ),
          gradient: LinearGradient(
            stops: [0.03, 0.54],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF3D3F42), Color(0xFF040436)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SlideTransition(
                position: _textOffsetAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: const Text(
                        "Projects",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: const Text(
                        "Most of my projects are listed On Github.",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: TextButton(
                        onPressed: () {
                          Information().prject();
                        },
                        child: Container(
                          width: 120,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Projects",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: _imageOffsetAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/project.jpg",
                    width: 250,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
