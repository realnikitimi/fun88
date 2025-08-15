import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final dynamic child;
  final double? width;
  final VoidCallback? onPressed;

  /// `ImageIcon` or `Icon`.
  final dynamic icon;

  Button({
    super.key,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
    this.color,
    this.width,
    this.icon,
    this.onPressed,
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

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            icon: icon,
            style: _baseButtonStyle
                .copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    backgroundColor ?? Colors.transparent,
                  ),
                )
                .merge(
                  width != null
                      ? ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(
                            Size.fromWidth(width!),
                          ),
                        )
                      : null,
                ),
            onPressed: onPressed,
            label: <Widget>() {
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
          )
        : TextButton(
            style: _baseButtonStyle
                .copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    backgroundColor ?? Colors.transparent,
                  ),
                )
                .merge(
                  width != null
                      ? ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(
                            Size.fromWidth(width!),
                          ),
                        )
                      : null,
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
