import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disciplined PDF Reader',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: PDFHomePage(),
    );
  }
}

class PDFHomePage extends StatefulWidget {
  @override
  _PDFHomePageState createState() => _PDFHomePageState();
}

class _PDFHomePageState extends State<PDFHomePage> {
  String? path;
  int lastPage = 0;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      path = prefs.getString('last_pdf_path');
      lastPage = prefs.getInt('last_page') ?? 0;
    });
  }

  Future<void> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        path = result.files.single.path!;
        lastPage = 0;
      });
      await prefs.setString('last_pdf_path', path!);
      await prefs.setInt('last_page', 0);
    }
  }

  void savePage(int pageIndex) async {
    await prefs.setInt('last_page', pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplined PDF Reader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: pickPDF,
          ),
        ],
      ),
      body: path != null
          ? SfPdfViewer.file(
              File(path!),
              key: _pdfViewerKey,
              initialScrollOffset: Offset(0, (lastPage * 100).toDouble()),
              onPageChanged: (details) => savePage(details.newPageNumber),
            )
          : const Center(
              child: Text('Pick a PDF to start reading'),
            ),
    );
  }
}
