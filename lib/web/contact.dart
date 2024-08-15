import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}
class _ContactState extends State<Contact> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _nameSlideAnimation;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<Offset> _messageSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationControllers
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -3), // Triple offset from above
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(-3, 0), // Triple offset from left
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(3, 0), // Triple offset from right
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    _messageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 3), // Triple offset from below
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    // Trigger animations
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String title = _titleController.text;
    final String message = _messageController.text;
    final String emailUri =
        'mailto:mzahoor575@gmail.com?subject=$title&body=Name: $name\nEmail: $email\n\n$message';
    if (await canLaunch(emailUri)) {
      await launch(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('contact-widget'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.1) {
          _slideController.forward();
        }
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Let's connect...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SlideTransition(
                        position: _nameSlideAnimation,
                        child: _buildGlassTextField('Name', _nameController, isMobile),
                      ),
                      const SizedBox(height: 10),
                      SlideTransition(
                        position: _emailSlideAnimation,
                        child: _buildGlassTextField('Email', _emailController, isMobile),
                      ),
                      const SizedBox(height: 10),
                      SlideTransition(
                        position: _titleSlideAnimation,
                        child: _buildGlassTextField('Title', _titleController, isMobile),
                      ),
                      const SizedBox(height: 10),
                      SlideTransition(
                        position: _messageSlideAnimation,
                        child: _buildGlassTextField('Message', _messageController, isMobile, maxLines: 4),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _sendEmail,
                        child: const Text('Send Email'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlassTextField(String hintText, TextEditingController controller, bool isMobile, {int maxLines = 1}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: isMobile ? double.infinity : 500,
          height: maxLines > 1 ? 150 : 70,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
