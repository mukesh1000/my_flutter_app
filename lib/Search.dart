
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? _searchStream;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _onSearchTextChanged();
    });
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.trim().toLowerCase();
    setState(() {
      if (searchText.isNotEmpty) {
        _searchStream = FirebaseFirestore.instance
            .collection('users')
            .where('Name', isGreaterThanOrEqualTo: searchText)
            .where('Name', isLessThanOrEqualTo: searchText + '\uf8ff')
            .snapshots();
      } else {
        _searchStream = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        title:TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search users',
              filled: true,
              prefixIcon: Icon(Icons.account_box, size: 28.0,color: Colors.black,),
              border: InputBorder.none,
            ),
          ),
        
      ),

      body: _searchStream != null
          ? StreamBuilder<QuerySnapshot>(
              stream: _searchStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching search results'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No results found'),
                  );
                }
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var user = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(user['Name']),
                      onTap: () {
                        // Navigate to user profile screen
                      },
                    );
                  },
                );
              },
            )
          : Center(
            child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Image.asset(
              'assests/heraldProfile.PNG',
              fit: BoxFit.contain,
              width: 200.0,
              height: 200.0,
            ),
             Text(
              'Find Alumni ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 28.0),
            )
          ],
        ),

              //child: Text('Start searching by entering a name or username'),
            ),
    );
  }
}

