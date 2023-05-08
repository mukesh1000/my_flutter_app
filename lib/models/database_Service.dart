import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);

  //reference for our collection

final CollectionReference userCollection = // it is done to create a user collection
FirebaseFirestore.instance.collection("users");
final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");
// final CollectionReference postsRef = FirebaseFirestore.instance.collection("posts");

// final StorageReference storageRef = FirebaseStorage.instance.ref(); 
final Reference storageRef = FirebaseStorage.instance.ref();
final user = FirebaseAuth.instance.currentUser!;



// updating the userdata
Future updateUserData(String Name, String Address, String Department, String Email, String displayname, String photoUrl, String bio) async {
  return await userCollection.doc(uid).set({
    "Name": Name,
    "Address": Address,
    "Department": Department,
    "Emal": Email,
    "uid": uid,
    "displayname": displayname,
    "photoUrl": photoUrl,
    "bio": bio,

  }

  );
}

}

