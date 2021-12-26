import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_media_info/mediainfo.dart';

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
  String _videoDuration = "Missing data";

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

    final result = mi.getInfo(
        MediaInfoStreamType.mediaInfoStreamVideo, 0, "Duration/String2");

    setState(() {
      _videoDuration = result;
    });
    mi.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_media_info example app'),
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
