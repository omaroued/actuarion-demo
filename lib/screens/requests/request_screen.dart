import 'package:actuarion/data/request.dart';
import 'package:actuarion/screens/add_request/add_request_screen.dart';
import 'package:actuarion/screens/request_details/request_details_screen.dart';
import 'package:actuarion/screens/requests/requests_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:actuarion/widgets/bounce.dart';
import 'package:actuarion/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestsScreen extends StatelessWidget {
  static const routeName = "/requests";
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requestNotifier = context.watch<RequestsNotifier>();
    final requests = requestNotifier.requests;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes demandes"),
        centerTitle: true,
      ),
      floatingActionButton: requestNotifier.requests.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, AddRequestScreen.routeName),
              child: const Icon(Icons.add),
            ),
      body: requests.isEmpty
          ? const _EmptyWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(20).add(EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)),
              itemBuilder: (context, index) => _RequestCard(request: requests[index]),
              itemCount: requests.length,
            ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/empty.svg", width: width / 3),
          const SizedBox(height: 10),
          Text("Pas de demandes", style: themeModel.theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          DefaultButton(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            onPressed: () => Navigator.pushNamed(context, AddRequestScreen.routeName),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.add, size: 20), SizedBox(width: 5), Text("Ajouter une demande")],
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Request request;
  const _RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    return Bounce(
      onPressed: () => Navigator.pushNamed(context, RequestDetailsScreen.routeName, arguments: request),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeModel.secondBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: themeModel.shadowColor, blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "#${request.id}",
                    style: themeModel.theme.textTheme.headlineMedium,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: request.status.color, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    request.status.title,
                    style: themeModel.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              request.title,
              style: themeModel.theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(request.createdAt)),
                style: themeModel.theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
