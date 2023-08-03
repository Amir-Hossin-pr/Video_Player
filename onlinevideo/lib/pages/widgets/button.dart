import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool outlined;
  final bool loading;
  final bool enable;
  final String lable;
  final Icon? icon;
  final Color? color;
  final Color loadingColor;
  final double borderRadius;
  final Function() onPressed;

  const Button({
    super.key,
    this.outlined = false,
    this.loading = false,
    this.enable = true,
    this.lable = 'Button',
    this.borderRadius = 5,
    this.color,
    this.loadingColor = Colors.lightBlue,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enable,
      child: outlined
          ? OutlinedButton(
              style: style(),
              onPressed: onPressed,
              child: child(),
            )
          : ElevatedButton(
              style: style(),
              onPressed: onPressed,
              child: child(),
            ),
    );
  }

  Widget child() {
    List<Widget> children = [];
    if (icon != null) {
      children.add(icon!);
    }
    if (!loading) {
      children.add(Text(lable));
    }
    if (loading) {
      children.add(CircularProgressIndicator(
        color: loadingColor,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  ButtonStyle style() => ButtonStyle(
        iconColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(15),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        backgroundColor: color != null ? MaterialStatePropertyAll(color) : null,
      );
}
