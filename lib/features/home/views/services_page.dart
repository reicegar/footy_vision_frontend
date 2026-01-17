import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  final double? height;
  const ServicesPage({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: Color(0xFFFFFFFF),
      child: Center(
        child: Text('Services', style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
