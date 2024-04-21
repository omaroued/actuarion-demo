import 'package:actuarion/data/request.dart';
import 'package:actuarion/screens/requests/requests_notifier.dart';
import 'package:actuarion/utils/toast_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AddRequestNotifier with ChangeNotifier {
  String _title = "";
  String _description = "";
  LocationData? _location;
  List<String> _images = [];
  List<String> _documents = [];

  List<String> get images => _images;
  List<String> get documents => _documents;

  bool get isLocationDetected => _location != null;

  bool get canFillTitleAndDescription => isLocationDetected;

  bool get canAddImages => _title.trim().isNotEmpty && _description.trim().isNotEmpty;

  bool get canAddDocuments => canAddImages && _images.isNotEmpty;

  bool get canSubmit => canAddDocuments;

  void onTitleChanged(String value) {
    _title = value;
    notifyListeners();
  }

  void onDescriptionChanged(String value) {
    _description = value;
    notifyListeners();
  }

  Future<void> getUserLocation() async {
    Location location = Location();

    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) return;
    }

    PermissionStatus isPermissionGranted = await location.hasPermission();

    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();
      if (isPermissionGranted != PermissionStatus.granted) return;
    }

    _location = await location.getLocation();
    notifyListeners();
  }

  Future<void> addImage() async {
    final imagePicker = ImagePicker();

    final result = await imagePicker.pickImage(source: ImageSource.camera);

    if (result != null) {
      _images = [..._images, result.path];
      notifyListeners();
    }
  }

  void removeImage(String image) {
    _images.remove(image);
    _images = [...images];
    notifyListeners();
  }

  Future<void> addFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: ["pdf"],
      type: FileType.custom,
    );

    if (result != null) {
      final filesNames = result.files.map((e) => e.name).toList();
      _documents = [..._documents, ...filesNames];
      notifyListeners();
    }
  }

  void removeFile(String file) {
    _documents.remove(file);
    _documents = [..._documents];
    notifyListeners();
  }

  void submit(BuildContext context) {
    final requestsNotifer = context.read<RequestsNotifier>();

    final id = requestsNotifer.requests.length;

    final request = Request(
      id: requestsNotifer.requests.length.toString(),
      title: _title.trim(),
      description: _description.trim(),
      createdAt: DateTime.now().toIso8601String(),
      latLng: LatLng(_location!.latitude!, _location!.longitude!),
      status: id % 3 == 0
          ? RequestStatus.pending
          : id % 3 == 1
              ? RequestStatus.rejected
              : RequestStatus.accepted,
      images: _images,
      documents: _documents,
    );

    requestsNotifer.addRequest(request);

    Navigator.pop(context);

    ToastUtils.show("Demande envoyée avec succès!");
  }
}
