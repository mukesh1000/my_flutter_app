import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);

  //reference for our collection

final CollectionReference userCollection = // it is done to create a user collection
FirebaseFirestore.instance.collection("users");
final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");


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