import 'dart:io';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import '../models/database_Service.dart';

final Reference storageRef = FirebaseStorage.instance.ref();
final CollectionReference postsRef =
    FirebaseFirestore.instance.collection("posts");
final user = FirebaseAuth.instance.currentUser!;

class upload extends StatefulWidget {
  //const upload({super.key});
  //final DatabaseService _selectedIndex;
  //User currentUser!;
  @override
  _uploadState createState() => _uploadState();

  static fromDocument(QueryDocumentSnapshot<Object?> doc) {}
}

class _uploadState extends State<upload> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  File? image;
  bool isUploading = false;
  String postId = Uuid().v4();

  handleTakePhoto() async {
    Navigator.pop(context);
    var photo = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      image = File(photo!.path);
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    var photo = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      image = File(photo!.path);
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create Post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Photo with Camera'),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text('Image from Gallery'),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  Container buildSplashScreen() {
    return Container(
      color: Colors.white,
      //color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Image.asset('assests/heraldProfile',height: 100, width: 100,),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () => selectImage(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(116, 192, 67, 1),
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text('Upload Image',
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          )
        ],
      ),
    );
  }

  clearImage() {
    setState(() {
      image = null;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(image!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    UploadTask uploadTask = storageRef.child("post_$postId.jpg").putFile(
        imageFile); //database.dart file import garnu parxa aani error hatxa so import gar
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore({
    required String mediaUrl,
    String? title,
    String? details,
  }) async {
    final User currentUser = FirebaseAuth.instance.currentUser!;
    final CollectionReference postsRef = FirebaseFirestore.instance
        .collection('Admin')
        .doc(currentUser.uid)
        .collection('userPosts');

    await postsRef.add({
      'mediaUrl': mediaUrl,
      'title': title ?? '',
      'details': details ?? '',
      'likes': {},
      'timestamp': FieldValue.serverTimestamp(),
    });
  }



  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(image);
    await createPostInFirestore(
      mediaUrl: mediaUrl,
      title: titleController.text,
      details: detailsController.text,
    );

    titleController.clear();
    detailsController.clear();
    setState(() {
      image = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: clearImage),
        title: Text(
          "Caption Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(116, 192, 67, 1)),
            ),
          ),
        ], // ACTION
      ),

      body: ListView(
        children: <Widget>[
          isUploading ? LinearProgressIndicator() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(image!),
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(116, 192, 67, 1),
              //backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: " Write about a Title ",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.post_add,
              color: Color.fromRGBO(116, 192, 67, 1),
              size: 35.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: detailsController,
                decoration: InputDecoration(
                  hintText: "Details about the Post",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              label: Text(
                "Post",
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                primary: Color.fromRGBO(116, 192, 67, 1),
              ),
              onPressed: isUploading ? null : () => handleSubmit(),
            ),
          ),
        ],
      ), // App Bar
    );
  }

  @override
  Widget build(BuildContext context) {
    return image == null ? buildSplashScreen() : buildUploadForm();
  }
}
