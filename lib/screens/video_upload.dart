import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoUpload extends StatefulWidget {
  @override
  _VideoUploadState createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  // List<String> _videos = <String>[];

  // bool _imagePickerActive = false;

  // Future _takeVideo() async {
  //   if (_imagePickerActive) return;

  //   _imagePickerActive = true;
  //   final File videoFile =
  //       await ImagePicker.pickVideo(source: ImageSource.camera);
  //   _imagePickerActive = false;

  //   if (videoFile == null) return;

  //   setState(() {
  //     _videos.add(videoFile.path);
  //   });
  // }
  String videoUrl;

  Future videoUpload() async {
    final _videoStorage = FirebaseStorage.instance;
    final _videoPicker = ImagePicker();

    PickedFile video;

    var permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      video = await _videoPicker.getVideo(source: ImageSource.gallery);
      var file = File(video.path);

      if (video != null) {
        var snapshot = await _videoStorage
            .ref()
            .child('videos/$file')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          videoUrl = downloadUrl;
        });
      } else {
        print('no path received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPLOAD YOUR VIDEO"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (videoUrl != null)
                ? Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    height: 500,
                    width: 500,
                    child: Image.network(
                      videoUrl,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      // Center(
      //   child: ListView.builder(
      //     padding: const EdgeInsets.all(8),
      //     itemCount: videoUrl.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Card(
      //         child: Container(
      //           padding: const EdgeInsets.all(8),
      //           child: Center(
      //             child: Text(
      //               videoUrl[index],
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: videoUpload,
        tooltip: 'Take Video',
        child: Icon(Icons.add),
      ),
    );
  }
}
