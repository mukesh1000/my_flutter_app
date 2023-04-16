import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAdmin extends StatefulWidget {
  const MyAdmin({super.key});

  @override
  State<MyAdmin> createState() => _MyAdminState();
}

class _MyAdminState extends State<MyAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        title: Text('Admin Page'),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 222, 218, 218),
                    contentPadding: EdgeInsets.only(right: 30),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 16, left: 24),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 24,
                      ),
                    )),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0),
            Container(
              height: 220.0,
              child: GridView(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3/2),
              children: <Widget>[
               
                _gridItem('assests/student.PNG', 'All Student'),
                _gridItem('assests/job.PNG', 'Jobs'),
                _gridItem('assests/Post.PNG', 'Post'),
                _gridItem('assests/profile.PNG', 'Profile'),
             

              ],
              ),
            ),


          ],
    ),
    ),
      );
  }
  _gridItem(img, name){
    return Column(
      children: <Widget>[

        Padding(
          padding:  const EdgeInsets.all(0.8),
          child: Container(
            height: 50,
            width: 50,
            //color: Colors.blue.withOpacity(0.8),
            child: Image.asset(
              img,
              ),
          )
        ),
        // CircleAvatar(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
            
        //     child: Image.asset(
        //       img,
        //       // size: 16.0,
        //       // color: Colors.white,
        //     ),
        //   ),
        //   backgroundColor: Colors.blue.withOpacity(0.9),
        // ),
        SizedBox(height: 10.0),
        Text(
          name,
        style: TextStyle(),
        )

      ],

    );

  }
}