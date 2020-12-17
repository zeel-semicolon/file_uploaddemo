import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  // File _image;
  String imageUrl;

  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 100,
  //     maxWidth: 100,
  //   );

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print("no image selected");
  //     }
  //   });
  // }

  // Future uploadFile() async {
  //   StorageReference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('chats/${Path.basename(_image.path)}}');

  //   StorageUploadTask uploadTask = storageReference.putFile(_image);
  //   await uploadTask.onComplete;
  //   print('File Uploaded');
  //   storageReference.getDownloadURL().then((fileURL) => {
  //         setState(() {
  //           _uploadedFileURL = fileURL;
  //         })
  //       });
  // }

  Future uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('images/$file')
            // .child('ImageFolder/imageName')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No path received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "UPLOAD YOUR IMAGE",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (imageUrl != null)
                ? Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    height: 500,
                    width: 500,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  )
                :
                // : Placeholder(
                //     fallbackHeight: 200.0,
                //     fallbackWidth: double.infinity,
                //   ),
                SizedBox(
                    height: 30,
                  ),
            RaisedButton(
              child: Text(
                "Upload Image",
              ),
              color: Colors.lightBlue,
              onPressed: () {
                uploadImage();
                print("success");
              },
            ),
          ],
        ),
      ),
    );
  }
}
