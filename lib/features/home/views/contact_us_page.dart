import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final double? height;
  const ContactUsPage({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: Color(0xFFFFFFFF),
      child: Center(
        child: Text('Contact US', style: TextStyle(color: Colors.green)),
      ),
    );
  }
}
