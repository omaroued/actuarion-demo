import 'dart:io';

import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:actuarion/widgets/bounce.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AddRequestImagesSection extends StatelessWidget {
  const AddRequestImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Selector<AddRequestNotifier, Tuple2<bool, List<String>>>(
      selector: (context, addRequestNotifier) => Tuple2(addRequestNotifier.canAddImages, addRequestNotifier.images),
      builder: (context, result, _) {
        final canAddImages = result.item1;
        final images = result.item2;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: canAddImages ? 1 : 0.5,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "3",
                        style: themeModel.theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Images capturées par la caméra:", style: themeModel.theme.textTheme.displaySmall)
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      return Center(
                        child: Bounce(
                          onPressed: canAddImages ? context.read<AddRequestNotifier>().addImage : null,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [5, 5],
                            color: themeModel.accentColor,
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: Icon(Icons.add, color: themeModel.accentColor),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(images[index]),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Bounce(
                              onPressed: canAddImages
                                  ? () => context.read<AddRequestNotifier>().removeImage(images[index])
                                  : null,
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.clear, color: Colors.white, size: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: images.length + 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
