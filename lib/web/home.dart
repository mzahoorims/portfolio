import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/information.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/abstract.png'), // Replace with your image path
          fit: BoxFit.fill,
        ),
        gradient: LinearGradient(
          stops: [0.03, 0.54],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF3D3F42), Color(0xFF040436)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Row(
          children: [
            Expanded(
              child: TweenAnimationBuilder(
                tween: Tween(
                  begin: Offset(-1.0, 0.0),
                  end: Offset.zero,
                ),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (context, offset, child) {
                  return Transform.translate(
                    offset: Offset(offset.dx * MediaQuery.of(context).size.width, offset.dy * MediaQuery.of(context).size.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hi, I am ${Information().name}",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          ">App developer",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 500,
                          child: Divider(
                            color: Colors.white54,
                            thickness: 4,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          " Building amazing things through lines of code.",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: Offset(offset.dx * MediaQuery.of(context).size.width, offset.dy * MediaQuery.of(context).size.height),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      "assets/profile.jpg",
                      width: 250,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
