import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/web/contact.dart';
import 'package:portfolio/web/experience.dart';
import 'package:portfolio/web/home.dart';
import 'package:portfolio/web/projects.dart';
import 'package:portfolio/web/social_links.dart';
import 'appbar.dart';

class Allwidgets extends StatefulWidget {
  const Allwidgets({super.key});

  @override
  State<Allwidgets> createState() => _AllwidgetsState();
}

class _AllwidgetsState extends State<Allwidgets> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _socialLinksKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onButtonPressed: _scrollToSection,
        homeKey: _homeKey,
        projectsKey: _projectsKey,
        experienceKey: _experienceKey,
        socialLinksKey: _socialLinksKey,
        contactKey: _contactKey,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/texture.png'), // Replace with your image path
                  fit: BoxFit.cover,
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: isMobile ? MediaQuery.of(context).size.height * 0.9 : MediaQuery.of(context).size.height,
                    child: Home(key: _homeKey),
                  ),
                  Projects(key: _projectsKey),
                  SocialLinks(key: _socialLinksKey),
                  Contact(key: _contactKey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
