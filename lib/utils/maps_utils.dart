import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsUtils {
  MapsUtils._();

  static Future<BitmapDescriptor> getPositionIcon(
    int size,
  ) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = const Color(0xFF23145D);

    final double width = size.toDouble();
    final double height = width;

    final Rect rect = Rect.fromLTWH(
      size / 2 - width / 2,
      size / 2 - height / 2,
      width,
      height,
    );
    final RRect roundedRect = RRect.fromRectAndRadius(rect, const Radius.circular(40));
    canvas.drawRRect(roundedRect, paint1);

    const iconData = Icons.location_on_outlined;

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        fontSize: size / 1.7,
        color: Colors.white,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
