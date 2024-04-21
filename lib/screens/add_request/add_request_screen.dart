
import 'package:actuarion/screens/add_request/add_request_notifier.dart';
import 'package:actuarion/screens/add_request/widgets/add_request_documents_section.dart';
import 'package:actuarion/screens/add_request/widgets/add_request_images_section.dart';
import 'package:actuarion/screens/add_request/widgets/add_request_location_section.dart';
import 'package:actuarion/screens/add_request/widgets/add_request_submit_section.dart';
import 'package:actuarion/screens/add_request/widgets/add_request_title_and_description_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRequestScreen extends StatelessWidget {
  static const routeName = "/add-request";
  const AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddRequestNotifier(),
      child: const _AddRequestScreen(),
    );
  }
}

class _AddRequestScreen extends StatefulWidget {
  const _AddRequestScreen();

  @override
  State<_AddRequestScreen> createState() => __AddRequestScreenState();
}

class __AddRequestScreenState extends State<_AddRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une demande"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                AddRequestLocationSection(),
                SizedBox(height: 20),
                AddRequestTitleAndDescriptionSection(),
                SizedBox(height: 20),
                AddRequestImagesSection(),
                SizedBox(height: 20),
                AddRequestDocumentsSection(),
                SizedBox(height: 30),
                AddRequestSubmitSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
