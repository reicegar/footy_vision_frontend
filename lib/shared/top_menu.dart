import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:footy_vision_frontend/shared/menu_handler.dart';
import 'package:google_fonts/google_fonts.dart';

class TopMenu extends StatefulWidget {
  final String currentSection;
  final Function(String route) goTo;
  final bool drawer;

  const TopMenu({super.key, required this.currentSection, required this.goTo, this.drawer = false});

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  late MenuHandler menuHandler;

  final Map<String, GlobalKey> _keys = {};
  String? hoveredRoute;

  @override
  void initState() {
    super.initState();
    menuHandler = MenuHandler();
  }

  // Get position and width of the selected button
  Rect? _getSelectionRect() {
    final selectedKey = _keys[widget.currentSection];
    if (selectedKey == null) return null;
    final renderBox = selectedKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    return position & renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    final options = menuHandler.options;
    for (final option in options) {
      _keys.putIfAbsent(option.fragment, () => GlobalKey());
    }

    final selectionRect = _getSelectionRect();

    Widget menuContent = Stack(
      children: [
        if (selectionRect != null)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            left: selectionRect.left,
            top: selectionRect.top,
            width: selectionRect.width,
            height: selectionRect.height,
            child: CustomPaint(painter: CornerBorderPainter(borderColor: FColors.orange, borderLength: 10.0, borderWidth: 2.0)),
          ),

        if (widget.drawer)
          Column(
            spacing: 10,
            children: [
              DrawerHeader(
                child: Center(child: Image.asset(FImage.assetImagePath, height: 40, fit: BoxFit.contain)),
              ),
              ..._options,
            ],
          )
        else
          Row(mainAxisSize: MainAxisSize.min, children: _options),
      ],
    );

    return widget.drawer ? Drawer(backgroundColor: FColors.black, child: menuContent) : menuContent;
  }

  List<Container> get _options => menuHandler.options.map((section) {
    final bool isSelected = section.fragment == widget.currentSection;
    final bool isHovered = section.fragment == hoveredRoute;
    return Container(
      key: _keys[section.fragment],
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onHover: (value) {
          setState(() {
            hoveredRoute = value ? section.fragment : null;
          });
        },
        style: TextButton.styleFrom(shadowColor: Colors.transparent, overlayColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
        onPressed: () => widget.goTo(section.fragment),
        child: Text(
          section.titleBuilder(context),
          style: GoogleFonts.oswald(
            color: isSelected || isHovered ? FColors.orange : Colors.white70,
            //fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ),
    );
  }).toList();
}

class CornerBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderLength;

  CornerBorderPainter({required this.borderColor, required this.borderWidth, required this.borderLength});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      // corner top left
      ..moveTo(0, borderLength)
      ..lineTo(0, 0)
      ..lineTo(borderLength, 0)
      // corner top right
      ..moveTo(size.width - borderLength, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, borderLength)
      // corner bottom right
      ..moveTo(size.width, size.height - borderLength)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - borderLength, size.height)
      // corner bottom left
      ..moveTo(borderLength, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - borderLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
