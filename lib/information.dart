import 'package:url_launcher/url_launcher.dart';
class Information {
  String name="Muhammad Zahoor";
  String projectLink="https://github.com/mzahoorims?tab=repositories";
  String linkedinLink="https://www.linkedin.com/in/muhammad-zahoor-1a8252248/";
  String instagramLink="https://www.instagram.com/zahoor1_1/";
  String facebookLink="";
  Future<void> prject() async {
    if (await canLaunch(projectLink)) {
      await launch(projectLink);
    } else {
      throw 'Could not launch $projectLink';
    }
  }
  Future<void> instagrem() async {
    if (await canLaunch(instagramLink)) {
      await launch(instagramLink);
    } else {
      throw 'Could not launch $instagramLink';
    }
  }
  Future<void> linkedin() async {
    if (await canLaunch(linkedinLink)) {
      await launch(linkedinLink);
    } else {
      throw 'Could not launch $linkedinLink';
    }
  }
}
