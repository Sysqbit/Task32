import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sysqbit_todo/config/router/app_routes.dart';
import 'package:sysqbit_todo/config/styles/colors/app_colors.dart';

import '../widgets/adaptive/adaptive_button.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdaptiveButton(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.black,
                    border: Border(
                      top: BorderSide(color: AppColors.black, width: 2),
                      left: BorderSide(color: AppColors.black, width: 2),
                      right: BorderSide(color: AppColors.black, width: 2),
                    )),
                width: 273,
                height: 117,
                alignment: Alignment.center,
                child: const Text(
                  'Dark Mode',
                  style: TextStyle(color: AppColors.white, fontSize: 20),
                ),
              ),
            ),
            AdaptiveButton(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 2)),
                width: 273,
                height: 117,
                alignment: Alignment.center,
                child: const Text(
                  'Light Mode',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            AdaptiveButton(
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary100),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(AppRouter.homePage)),
            AdaptiveButton(
                child: const CustomPaint(
                  size: Size(
                    double.infinity,
                    30,
                  ),
                  painter:
                      TextScrollPainter(label1: "complete", label2: "Complete"),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(AppRouter.homePage)),
            const CustomPaint(
              size: Size(
                double.infinity,
                30,
              ),
              painter:
                  TextScrollPainter(label1: "complete", label2: "Complete"),
            ),
          ],
        ),
      ),
    ));
  }
}

class TextScrollPainter extends CustomPainter {
  const TextScrollPainter(
      {required this.label1, required this.label2, this.scrollPosition = 0.0});
  final String label1;
  final String label2;
  final double scrollPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      maxLines: 1,
    ))
      ..addText(label1);
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: size.width));

    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
