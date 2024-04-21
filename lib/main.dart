import 'package:actuarion/data/request.dart';
import 'package:actuarion/screens/add_request/add_request_screen.dart';
import 'package:actuarion/screens/request_details/request_details_screen.dart';
import 'package:actuarion/screens/requests/request_screen.dart';
import 'package:actuarion/screens/requests/requests_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => RequestsNotifier()),
      ],
      child: Consumer<ThemeModel>(builder: (context, themeModel, _) {
        return MaterialApp(
          title: 'Actuarion client',
          theme: themeModel.theme,
          routes: {
            RequestsScreen.routeName: (_) => const RequestsScreen(),
            AddRequestScreen.routeName: (_) => const AddRequestScreen(),
            RequestDetailsScreen.routeName: (context) {
              final request = ModalRoute.of(context)!.settings.arguments as Request?;

              if (request == null) return const SizedBox();

              return RequestDetailsScreen(request: request);
            },
          },
          initialRoute: RequestsScreen.routeName,
        );
      }),
    );
  }
}
