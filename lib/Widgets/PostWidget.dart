// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// final CollectionReference userCollection = // it is done to create a user collection
// FirebaseFirestore.instance.collection("users");
// final user = FirebaseAuth.instance.currentUser!;


// class PostWidget extends StatefulWidget {
//   //const PostWidget({super.key});
//   final String postId;
//   final String mediaUrl;
//   final String title;
//   final String details;
//   final dynamic likes;

//   PostWidget({

//   required this.postId,
//   required this.mediaUrl,
//   required this.title,
//   required this.details,
//   required this.likes,
//   });

//   factory PostWidget.fromDocument(DocumentSnapshot doc) {
//     return PostWidget(
//       postId: doc['postId'],
//       title: doc['title'],
//       details: doc['details'],
//       mediaUrl: doc['mediaUrl'],
//       likes: doc['likes'],
//     );
//   }

//   int getLikeCount(likes) {
//     if (likes == {}) {
//       return 0;
//     }

//     int count = 0;
//     likes.values.forEach((val) {
//       if (val == true) {
//         count += 1;
//       }
//     });
//     return count;
//   }


 


//   @override
//   State<PostWidget> createState() => _PostWidgetState(
//     postId: this.postId,
//     mediaUrl: this.mediaUrl,
//     title: this.title,
//     details: this.details,
//     likes: this.likes,
//     likeCount: getLikeCount(this.likes),

//   );

// }

// class _PostWidgetState extends State<PostWidget> {

//   final String postId;
//   final String mediaUrl;
//   final String title;
//   final String details;
//   int likeCount;
//   Map likes;
  

//   _PostWidgetState({

//   required this.postId,
//   required this.mediaUrl,
//   required this.title,
//   required this.details,
//   required this.likes,
//   required this.likeCount,
//   });

//   buildPostHeader(){
//     return FutureBuilder(
//       future: userCollection.doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return CircularProgressIndicator();
//         }
//         User user = User.fromDocument(snapshot.data!);
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: CachedNetworkImageProvider(user.photoURL),
//             backgroundColor: Colors.grey,
          
//           ),

//         );

//       },
//       );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         buildPostHeader(),
//         buildPostImage(),
//         buildPostFooter(),
//       ],

//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
final user = FirebaseAuth.instance.currentUser!;

class PostWidget extends StatefulWidget {
  final String postId;
  final String mediaUrl;
  final String title;
  final String details;
  final dynamic likes;

  PostWidget({
    required this.postId,
    required this.mediaUrl,
    required this.title,
    required this.details,
    required this.likes,
  });

  factory PostWidget.fromDocument(DocumentSnapshot doc) {
    return PostWidget(
      postId: doc['postId'],
      title: doc['title'],
      details: doc['details'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    if (likes == {}) {
      return 0;
    }

    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late User user;
  late int likeCount;
  late Map likes;

  @override
  void initState() {
    super.initState();
    getUser();
    likeCount = widget.getLikeCount(widget.likes);
    likes = widget.likes;
  }

  void getUser() async {
    final snapshot = await userCollection.doc(widget.postId).get();
    //user = User.fromDocument(snapshot) ;
    setState(() {});
  }

  Widget buildPostHeader() {
    if (user == null) {
      return CircularProgressIndicator();
    }
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.photoURL!),
        backgroundColor: Colors.grey,
      ),
      title: GestureDetector(
              onTap: () => print("Showing Profie"),
              child: Text(
                user.uid,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(widget.details),
            trailing: IconButton(
              onPressed:() => print('deleting post'),
              icon: Icon(Icons.more_vert),
               ),

    );
    
  }

  Widget buildPostImage() {
    return GestureDetector(
      onDoubleTap: () => print("Liking Post"),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(widget.mediaUrl),
        ],
        ),

    );
  }
  //   return Container(
  //     height: 400.0,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: NetworkImage(widget.mediaUrl),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }

  Widget buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
            ),
            GestureDetector(
              onTap: () => print("Liking Post"),
              child: Icon(
                Icons.favorite_border,
                size: 28.0,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
            GestureDetector(
              onTap: () => print("showing Comments"),
              child: Icon(
                Icons.chat,
                size: 28.0,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$widget.title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),

            ),
            Expanded(child: Text(widget.details))
          ],
        )
      ],
    );       

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter(),
      ],
    );
  }
}
             
