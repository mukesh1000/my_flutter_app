import 'dart:io';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import '../models/database_Service.dart';

class upload extends StatefulWidget {
  //const upload({super.key});
  //final DatabaseService _selectedIndex;


  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
   File? image;
   bool isUploading = false;

  handleTakePhoto() async {
    Navigator.pop(context);
      var photo = await ImagePicker().pickImage(
      source: ImageSource.camera,
    maxHeight: 675,
    maxWidth: 960, );
    setState(() {
      image = File(photo!.path);
    });
  }

  handleChooseFromGallery() async{
    Navigator.pop(context);
     var photo = await ImagePicker().pickImage(
      source: ImageSource.camera,);

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
            padding: EdgeInsets.only(top: 20,),
            child: Center(
              child: ElevatedButton(
                onPressed: () => selectImage(context),
              //  shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0),
              //   ),
                // child: Text(
                //   "Upload Image",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 22.0,
                //   ),
                // ),
                // Color: Color.fromRGBO(116, 192, 67, 1),
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

  compressImage() async{
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(image!.readAsBytesSync());

    
  }

  handleSubmit(){
    setState(() {
      isUploading = true;
    });

  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        leading: IconButton(
          icon:Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: clearImage
           ),
           title: Text(
          "Caption Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            onPressed: isUploading ? null :() => handleSubmit(),
            child: Text( 
              "Post",
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(116, 192, 67, 1)),
            ),
          ),
        ], // ACTION
      ),
      
      body: ListView(
        children: <Widget> [
          isUploading ? LinearProgressIndicator() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(aspectRatio: 16 /9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(image!),
                    )
                ),

              ),
              ), 
              ),
          ),

          Padding(padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(116, 192, 67, 1),
             //backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
              decoration: InputDecoration(
                hintText:" Write about a Title ",
                border: InputBorder.none, 
                ),
                 ),
                  ),
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.post_add, color: Color.fromRGBO(116, 192, 67, 1),size: 35.0,),
            title: Container(
              width: 250.0,
              child: TextField(
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
              label: Text("Post",
              style: TextStyle(color: Colors.black),
              ),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Color.fromRGBO(116, 192, 67, 1),
                  ),
                  onPressed: () => print("Pressed"),
                  ),
                  ),
  




        ],
      ), // App Bar

    );
  }
  
  @override
  Widget build(BuildContext context) {
    return image == null ? buildSplashScreen(): buildUploadForm();
  }
}