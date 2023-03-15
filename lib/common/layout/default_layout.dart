import 'package:flutter/material.dart';

class DefalutLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;

  const DefalutLayout({
    this.backgroundColor,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      // resizeToAvoidBottomInset: false,
      body: child,
    );
  }
}
