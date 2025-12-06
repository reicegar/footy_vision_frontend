import 'package:flutter/material.dart';

class PageSection extends StatefulWidget {
  final String title;
  final Color color;
  final double height;

  const PageSection({required this.title, required this.color, required this.height, super.key});

  @override
  State<PageSection> createState() => _PageSectionState();
}

class _PageSectionState extends State<PageSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      height: widget.height,
      color: widget.color.withValues(alpha: 0.8),
      alignment: Alignment.center,
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
