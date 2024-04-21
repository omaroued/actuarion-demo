import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:actuarion/widgets/bounce.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AddRequestDocumentsSection extends StatelessWidget {
  const AddRequestDocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Selector<AddRequestNotifier, Tuple2<bool, List<String>>>(
      selector: (context, addRequestNotifier) =>
          Tuple2(addRequestNotifier.canAddDocuments, addRequestNotifier.documents),
      builder: (context, result, _) {
        final canAddDocuments = result.item1;
        final documents = result.item2;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: canAddDocuments ? 1 : 0.5,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "4",
                        style: themeModel.theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Documents(Optionnel):", style: themeModel.theme.textTheme.displaySmall)
                ],
              ),
              ...documents.map((document) => Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(color: themeModel.secondTextColor)),
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf, color: Colors.red, size: 25),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            document,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: themeModel.theme.textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Bounce(
                          onPressed:
                              canAddDocuments ? () => context.read<AddRequestNotifier>().removeFile(document) : null,
                          child: const Icon(Icons.clear, color: Colors.red, size: 25),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Bounce(
                onPressed: canAddDocuments ? context.read<AddRequestNotifier>().addFiles : null,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [5, 5],
                  color: themeModel.accentColor,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: themeModel.accentColor),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Ajouter des documents",
                            style: themeModel.theme.textTheme.titleLarge?.copyWith(color: themeModel.accentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
