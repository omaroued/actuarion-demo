import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRequestTitleAndDescriptionSection extends StatefulWidget {
  const AddRequestTitleAndDescriptionSection({super.key});

  @override
  State<AddRequestTitleAndDescriptionSection> createState() => AddRequestTitleAndDescriptionSectionState();
}

class AddRequestTitleAndDescriptionSectionState extends State<AddRequestTitleAndDescriptionSection> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    final addRequestNotifier = context.read<AddRequestNotifier>();

    return Selector<AddRequestNotifier, bool>(
      selector: (context, addRequestNotifier) => addRequestNotifier.canFillTitleAndDescription,
      builder: (context, canFillTitleAndDescription, __) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: canFillTitleAndDescription ? 1 : 0.5,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "2",
                        style: themeModel.theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Information sur la demande:", style: themeModel.theme.textTheme.displaySmall)
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                enabled: canFillTitleAndDescription,
                controller: _titleController,
                onChanged: addRequestNotifier.onTitleChanged,
                textInputAction: TextInputAction.next,
                maxLength: 30,
                decoration: const InputDecoration(hintText: "Titre/Motif", helperText: "30 caractères maximum"),
              ),
              const SizedBox(height: 10),
              TextField(
                enabled: canFillTitleAndDescription,
                controller: _descriptionController,
                onChanged: addRequestNotifier.onDescriptionChanged,
                textInputAction: TextInputAction.done,
                minLines: 4,
                maxLength: 300,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Description",
                  helperText: "300 caractères maximum",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
