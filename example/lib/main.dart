import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mediainfo/mediainfo.dart';
import 'package:mediainfo/models/media_info_stream_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _fileName = "";
  String _filePath = "";
  String _videoDuration = "Brak danych ";

  Future<void> _openMp4File(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'videos',
      extensions: <String>['mp4'],
    );
    final List<XFile> files =
        await openFiles(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    final XFile file = files[0];
    final String fileName = file.name;
    final String filePath = file.path;

    setState(() {
      _fileName = fileName;
      _filePath = filePath;
    });

    getFileData();
  }

  @override
  void initState() {
    super.initState();
  }

  void getFileData() {
    final mi = Mediainfo.init();
    mi.quickLoad(_filePath);

    final info_parameters = mi.option("Info_Parameters");
    final info_codecs = mi.option("Info_Codecs");

    final result = mi.getInfo(
        MediaInfoStreamType.mediaInfoStreamVideo, 0, "Duration/String2");

    setState(() {
      _videoDuration = result;
    });
    mi.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Media Info Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            Column(
              children: [
                Text("File: $_fileName"),
                Text("Duration: $_videoDuration"),
                MaterialButton(
                  onPressed: () => _openMp4File(context),
                  child: const Text("Get video data"),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
