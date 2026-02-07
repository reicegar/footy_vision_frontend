import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  final double? height;
  const ServicesPage({super.key, this.height});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          width: double.infinity,
          color: Color(0xFFFFFFFF),
          child: Center(
            child: Text('Services', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleText({String? title, double? maxSize, TextAlign? align, Color? textColor}) {
    return SizedBox(
      // Ensure it has a defined area to fill
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: align == TextAlign.left ? Alignment.centerLeft : Alignment.center,
        child: Text(
          title ?? 'TITLE',
          textAlign: align,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: textColor, fontSize: maxSize),
        ),
      ),
    );
  }
}
