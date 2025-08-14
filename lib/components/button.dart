import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
    this.color,
    required this.child,
  });

  final _baseButtonStyle =
      ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsetsGeometry.all(12)),
      ).merge(
        TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final dynamic child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _baseButtonStyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? Colors.transparent,
        ),
      ),
      onPressed: () => debugPrint('Access'),
      child: <Widget>() {
        switch (child.runtimeType.toString()) {
          case "String":
            return Text(
              child,
              softWrap: true,
              style: TextStyle(
                fontSize: fontSize ?? 12,
                fontFamily: 'Poppins',
                fontWeight: fontWeight ?? FontWeight.w300,
                color: color ?? Colors.white,
              ),
            );
          case "Icon":
            return child;
          default:
            return SizedBox();
        }
      }(),
    );
  }
}
