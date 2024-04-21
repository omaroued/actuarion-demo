import 'dart:math';

import 'package:actuarion/theme_model.dart';
import 'package:actuarion/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatelessWidget {
  final String image;
  final String title;
  static Future<bool?> show(BuildContext context, {required String image, required String title}) {
    return showDialog(context: context, builder: (context) => ConfirmDialog._(title: title, image: image));
  }

  const ConfirmDialog._({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: max(width / 2 - 250, 20)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: themeModel.secondBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                image,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: themeModel.theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    height: 40,
                    color: const Color(0xFFAAAAAA),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Annuler"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DefaultButton(
                    height: 40,
                    color: const Color(0xFFFF3E3E),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Confirmer"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
