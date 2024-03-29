import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_flutter_app/Admin/upload.dart';

//final timelineRef = FirebaseFirestore.instance.collection('timeline');

class MyPost extends StatefulWidget {
  //final String userId;

   //const MyPost({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
  
}

class _MyPostState extends State<MyPost> {
  // final String currentUserId = currentUser?.id;
  late Stream<List<Post>> _postsStream;
  // bool isLoading = false;
  // int postCount = 0;
  // List<upload> posts = [];

   @override
  void initState() {
    super.initState();
    _postsStream = FirebaseFirestore.instance
        .collection('Admin')
        .doc('xtbeiEvY8ZV2uXDjQk4oDvnV0EI2')
        .collection('userPosts')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post(
                  title: doc['title'],
                  details: doc['details'],
                  mediaUrl: doc['mediaUrl'],
                  // likes: doc['likes'],
                  // comments: doc['comments'],
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Post>>(
        stream: _postsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(116, 192, 67, 1),
              //backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
             title: Text(post.title),
             subtitle: Text(post.details),
          ),

            // Text(post.title),
            // Text(post.details),

             SizedBox(
                height: 10,
                ),
          
                  SizedBox(
                    height: 300,
                    width: 410,
                    child:Image.network(
                      post.mediaUrl,
                      fit: BoxFit.cover,
                      ),
                      ),

                       SizedBox(
                height: 30,
                ),
                  
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class Post {
  final String title;
  final String details;
  final String mediaUrl;
  // final int likes;
  // final int comments;

  Post({
    required this.title,
    required this.details,
    required this.mediaUrl,
    // required this.likes,
    // required this.comments,

  });
}
  
  