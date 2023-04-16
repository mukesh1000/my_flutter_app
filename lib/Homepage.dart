import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_flutter_app/EditProfileScreen.dart';
import 'package:my_flutter_app/Post.dart';
import 'package:my_flutter_app/Profile_screen.dart';
import 'package:my_flutter_app/Search.dart';
import 'package:my_flutter_app/models/database_Service.dart';

//DatabaseService currentUser;

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {

  int _selectedIndex = 0;
  //  List<Widget> _widgetoptions = <Widget>[
  //   MyPost(),
  //   MySearch(),
  //   ProfileScreen(),

  // ];

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        title: Text(
          'Alumnus',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      // body:  _widgetoptions.elementAt(_selectedIndex),
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
            Padding(
              padding: EdgeInsets.all(16.0),
              child:Row(children: <Widget>[
                Text("Latest",
                style:TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                )

              ],
              ),

            ),
            _cardItem('assests/sports week.PNG', 'Sports week','Some clips of SportsWeek','Herald college Kathmandu'),
            _cardItem('assests/holi.PNG', 'Happy Holi','Some clips of Holi','Herald College Kathmandu'),
            _cardItem('assests/global.PNG', 'Global Money Week','Lets create a brighter financial future ','OECD'),
            _cardItem('assests/Brisk.PNG', 'Code Brisk Hackathon','Code at 3842m Altitude Kalichowk','Herald Devcorps'),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.blue,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       ),
      //   ],
      // ),

      // child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300]!,
      //         hoverColor: Colors.grey[100]!,
      //         activeColor: Colors.black,
      //         iconSize: 24,
      //         //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 400),
      //         backgroundColor: Colors.blue,
      //         tabBackgroundColor: Colors.grey[100]!,
      //         color: Colors.white,
      //         padding: EdgeInsets.all(8),
      //         gap: 8,
      //         tabs: const [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             icon: Icons.favorite_border,
      //             text: 'Likes',
      //           ),
      //           GButton(
      //             icon: Icons.search,
      //             text: 'Search',
      //           ),
      //           GButton(
      //             icon: Icons.account_circle,
      //             text: 'Profile'
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
        
      //   ),
      //     ),
      // ),
      // ),
    );
    
  } //widget built

  _cardItem(Image, title, subtitle , organizer) {
    return Padding(padding: EdgeInsets.all(16.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Image),
              fit: BoxFit.cover,
              ),
              
          ),
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(title,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              ),
              ),
              SizedBox(height: 10.0),
              Text(subtitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(organizer,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                ),
              )


            
          ],
        )

    ],
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
} // homepage
