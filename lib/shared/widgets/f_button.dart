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

class _FButtonState<T> extends State<FButton<T>> {
  bool _disabled = false;

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
    return Stack(
      children: [
        CustomPaint(painter: CornerBorderPainter(borderColor: FColors.orange, borderLength: 10.0, borderWidth: 2.0)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: _disabled ? null : () => _handlePressed(null),
          child: Text(widget.label),
        ),
      ],
    );
  }
}
