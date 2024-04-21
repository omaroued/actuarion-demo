import 'dart:io';
import 'dart:math';
import 'package:actuarion/data/request.dart';
import 'package:actuarion/screens/request_details/request_image_details.dart';
import 'package:actuarion/screens/requests/requests_notifier.dart';
import 'package:actuarion/theme_model.dart';
import 'package:actuarion/transitions/fade_route.dart';
import 'package:actuarion/utils/maps_utils.dart';
import 'package:actuarion/utils/toast_utils.dart';
import 'package:actuarion/widgets/bounce.dart';
import 'package:actuarion/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

class RequestDetailsScreen extends StatefulWidget {
  static const routeName = "/request-details";

  final Request request;
  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late CameraPosition _currentCameraPosition = CameraPosition(
    target: widget.request.latLng,
    zoom: 14,
  );

  BitmapDescriptor? customIcon;

  void _createMarkerImageFromAsset(BuildContext context) async {
    final width = MediaQuery.of(context).size.width;

    customIcon = await MapsUtils.getPositionIcon(min(width ~/ 4, 100));
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _createMarkerImageFromAsset(context);
    });
    super.initState();
  }

  Future<void> deleteRequest() async {
    final isConfirmed = await ConfirmDialog.show(
      context,
      image: "assets/images/trash.png",
      title: "Êtes-vous sûr de vouloir supprimer cette demande?",
    );

    if ((isConfirmed ?? false) && context.mounted) {
      final requestNotifier = context.read<RequestsNotifier>();
      requestNotifier.removeRequest(widget.request);

      ToastUtils.show("Demande supprimée avec succès!");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Détails de la demande"),
        actions: [IconButton(onPressed: deleteRequest, icon: const Icon(Icons.delete, color: Colors.red))],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeModel.secondBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: themeModel.shadowColor, blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "#${widget.request.id}",
                          style: themeModel.theme.textTheme.headlineMedium,
                        ),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: widget.request.status.color, borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          widget.request.status.title,
                          style: themeModel.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeModel.secondBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: themeModel.shadowColor, blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date de demande:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(widget.request.createdAt)),
                        style: themeModel.theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Titre de demande:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.request.title,
                        style: themeModel.theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Description de demande:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.request.description,
                        style: themeModel.theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeModel.secondBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: themeModel.shadowColor, blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Localisation:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 300,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: true,
                            zoomGesturesEnabled: true,
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                            markers: customIcon != null
                                ? {
                                    Marker(
                                      markerId: const MarkerId("current"),
                                      position: widget.request.latLng,
                                      icon: customIcon!,
                                    ),
                                  }
                                : {},
                            initialCameraPosition: _currentCameraPosition,
                            onCameraMove: (newPosition) {
                              setState(() {
                                _currentCameraPosition = newPosition;
                              });
                            },
                            onMapCreated: (GoogleMapController controller) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Les photos prises par la camera:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Bounce(
                            onPressed: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page:
                                      RequestImageDetailsScreen(images: widget.request.images, initialPosition: index),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              margin: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(widget.request.images[index]),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          itemCount: widget.request.images.length,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Documents supplémentaires:",
                        style: themeModel.theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      ...widget.request.documents.map((document) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.picture_as_pdf, color: Colors.red, size: 25),
                                const SizedBox(width: 10),
                                Text(
                                  document,
                                  style: themeModel.theme.textTheme.titleLarge
                                      ?.copyWith(decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
