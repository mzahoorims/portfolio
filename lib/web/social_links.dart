import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/information.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({super.key});

  @override
  _SocialLinksState createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _linkedinController;
  late AnimationController _githubController;
  late AnimationController _instagramController;

  late Animation<Offset> _textOffsetAnimation;
  late Animation<Offset> _linkedinOffsetAnimation;
  late Animation<Offset> _githubOffsetAnimation;
  late Animation<Offset> _instagramOffsetAnimation;
  late Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationControllers
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _linkedinController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _githubController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _instagramController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define Animations with larger offset
    _textOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 4), // Larger offset from below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _linkedinOffsetAnimation = Tween<Offset>(
      begin: const Offset(-4, 0), // Doubled offset from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _linkedinController,
      curve: Curves.easeInOut,
    ));

    _githubOffsetAnimation = Tween<Offset>(
      begin: const Offset(4, 0), // Doubled offset from right
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _githubController,
      curve: Curves.easeInOut,
    ));

    _instagramOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 4), // Doubled offset from below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _instagramController,
      curve: Curves.easeInOut,
    ));

    // Define scaling animation for the text
    _textScaleAnimation = Tween<double>(
      begin: 0.5, // Start scaled down
      end: 1.0,   // End at normal size
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  void _triggerAnimations() {
    _textController.forward();
    _linkedinController.forward();
    _githubController.forward();
    _instagramController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('social-links-widget'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.1) {
          _triggerAnimations();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              ScaleTransition(
                scale: _textScaleAnimation,
                child: SlideTransition(
                  position: _textOffsetAnimation,
                  child: const Text(
                    "Follow me on my social links",
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SlideTransition(
                position: _linkedinOffsetAnimation,
                child: InkWell(
                  onTap: () {
                    Information().linkedin();
                  },
                  child: _buildSocialLink('assets/linkedin.png', 'LinkedIn'),
                ),
              ),
              const SizedBox(height: 30),
              SlideTransition(
                position: _githubOffsetAnimation,
                child: InkWell(
                  onTap: () {
                    Information().prject();
                  },
                  child: _buildSocialLink('assets/github.png', 'GitHub'),
                ),
              ),
              const SizedBox(height: 30),
              SlideTransition(
                position: _instagramOffsetAnimation,
                child: InkWell(
                  onTap: () {
                    Information().instagrem();
                  },
                  child: _buildSocialLink('assets/instagram.png', 'Instagram'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink(String imagePath, String title) {
    return GlassContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 50,
              width: constraints.maxWidth < 600 ? constraints.maxWidth * 0.8 : 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2.5,
                ),
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
