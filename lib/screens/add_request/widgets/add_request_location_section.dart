import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:actuarion/widgets/bounce.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRequestLocationSection extends StatelessWidget {
  const AddRequestLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "1",
                  style: themeModel.theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text("Localistion:", style: themeModel.theme.textTheme.displaySmall)
          ],
        ),
        const SizedBox(height: 10),
        Selector<AddRequestNotifier, bool>(
          selector: (context, addRequestNotifier) => addRequestNotifier.isLocationDetected,
          builder: (context, isLocationDetected, _) {
            if (isLocationDetected) {
              return Container(
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_box_outlined, color: Colors.white),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "Localisation détectée",
                        style: themeModel.theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            }

            return Bounce(
              onPressed: context.read<AddRequestNotifier>().getUserLocation,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [5, 5],
                color: themeModel.accentColor,
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: themeModel.accentColor),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "Detecter ma localisation",
                          style: themeModel.theme.textTheme.titleLarge?.copyWith(color: themeModel.accentColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
