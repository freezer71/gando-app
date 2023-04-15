import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({Key? key}) : super(key: key);
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conditions d'utilisation"),
        backgroundColor: AppTheme.darkColor,
      ),
      body: SfPdfViewer.network(
        'https://mygando.com/static/media/CGU.d7ae0e03bea6391fd416.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
