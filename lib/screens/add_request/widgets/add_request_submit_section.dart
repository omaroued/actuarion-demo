import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRequestSubmitSection extends StatelessWidget {
  const AddRequestSubmitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AddRequestNotifier, bool>(
      selector: (context, addRequestNotifier) => addRequestNotifier.canSubmit,
      builder: (context, canSubmit, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: canSubmit ? 1 : 0.5,
          child: DefaultButton(
            width: double.infinity,
            height: 55,
            onPressed: canSubmit ? () => context.read<AddRequestNotifier>().submit(context) : null,
            child: const Text("Ajouter une demande"),
          ),
        );
      },
    );
  }
}
