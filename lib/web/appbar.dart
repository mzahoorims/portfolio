import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(GlobalKey) onButtonPressed;
  final GlobalKey homeKey;
  final GlobalKey projectsKey;
  final GlobalKey experienceKey;
  final GlobalKey socialLinksKey;
  final GlobalKey contactKey;

  const CustomAppBar({
    required this.onButtonPressed,
    required this.homeKey,
    required this.projectsKey,
    required this.experienceKey,
    required this.socialLinksKey,
    required this.contactKey,
    super.key,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedAppBarButton("Home", widget.homeKey),
            _buildSeparator(),
            _buildAnimatedAppBarButton("Projects", widget.projectsKey),
            _buildSeparator(),
            _buildAnimatedAppBarButton("Experience", widget.experienceKey),
            _buildSeparator(),
            _buildAnimatedAppBarButton("Social links", widget.socialLinksKey),
            _buildSeparator(),
            _buildAnimatedAppBarButton("Contact", widget.contactKey),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedAppBarButton(String title, GlobalKey key) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: TextButton(
              onPressed: () => widget.onButtonPressed(key),
              child: Text(
                title,
                style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)
              ),
            ),
           ),
        );
      },
    );
  }

  Widget _buildSeparator() {
    return Row(
      children: const [
        Text("|", style: TextStyle( color: Colors.blueAccent,)),

        SizedBox(width: 18),
      ],
    );
  }
}
