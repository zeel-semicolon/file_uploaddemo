import 'package:file_uploaddemo/screens/document_upload.dart';
import 'package:file_uploaddemo/screens/image_upload.dart';
import 'package:file_uploaddemo/screens/video_upload.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FILE UPLOADING DEMO"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
        padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Column(
          children: <Widget>[
            Text(
              "What you choose to upload?",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ImageUpload(),
                  ),
                );
              },
              color: Colors.blue,
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              label: Text(
                "UPLOAD IMAGE",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VideoUpload(),
                  ),
                );
              },
              color: Colors.blue,
              icon: Icon(
                Icons.video_library,
                color: Colors.white,
              ),
              label: Text(
                "UPLOAD VIDEO",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FilePickerDemo(),
                  ),
                );
              },
              color: Colors.blue,
              icon: Icon(
                Icons.file_upload,
                color: Colors.white,
              ),
              label: Text(
                "UPLOAD DOCUMENT",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
