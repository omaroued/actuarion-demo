import 'package:actuarion/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double height;
  final double? width;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;

  final double? elevation;

  const DefaultButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 45,
    this.width,
    this.color,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: themeModel.theme.textButtonTheme.style?.copyWith(
            backgroundColor:
                color != null ? MaterialStateProperty.all(color) : MaterialStatePropertyAll(themeModel.accentColor),
            elevation: MaterialStatePropertyAll(elevation)),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
