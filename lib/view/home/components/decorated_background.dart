import 'package:flutter/material.dart';
import 'package:meditation/data_models/meiso_theme.dart';

class DecoratedBackground extends StatelessWidget {
  final MeisoTheme theme;

  const DecoratedBackground({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: Image.asset(
        theme.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
