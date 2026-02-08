import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:footy_vision_frontend/shared/styles.dart';

class FButton<T> extends StatefulWidget {
  final String label;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onPressed;
  const FButton({super.key, required this.label, this.onPressed, this.onChanged});

  @override
  State<FButton<T>> createState() => _FButtonState<T>();
}

class _FButtonState<T> extends State<FButton<T>> with SingleTickerProviderStateMixin {
  bool _disabled = false;
  bool _isHovered = false;

  @override
  void didUpdateWidget(covariant FButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onChanged != widget.onChanged || oldWidget.onPressed != widget.onPressed) {
      setState(() {
        _disabled = widget.onChanged == null && widget.onPressed == null;
      });
    }
  }

  void _handlePressed(T? value) {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onHover: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: CustomPaint(
        painter: CornerBorderPainter(borderColor: _isHovered ? FColors.orangeDarkSoft : FColors.blackSoft, borderLength: 12.0, borderWidth: 1.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
              backgroundColor: FColors.blackSoft,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
            ).copyWith(visualDensity: VisualDensity.compact),
            onPressed: _disabled ? null : () => _handlePressed(null),
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: _isHovered ? constraints.maxWidth : 0,
                        color: FColors.orangeDarkSoft,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.label, style: theme.textTheme.bodyMedium?.copyWith(color: _isHovered ? FColors.blackSoft : Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
