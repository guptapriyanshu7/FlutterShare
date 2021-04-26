import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/widgets/progress.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot> searchResultsFuture;
  final searchController = TextEditingController();
  void clearForm() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Users',
            filled: true,
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearForm,
            ),
          ),
          onFieldSubmitted: (val) {
            final users = usersRef
                .where("displayName", isGreaterThanOrEqualTo: val)
                .get();
            setState(() {
              searchResultsFuture = users;
            });
          },
        ),
      ),
      body: searchResultsFuture == null
          ? Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Find Users',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: searchResultsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return circularIndicator();
                }
                List<UserResult> searchResults = [];
                snapshot.data.docs.forEach((doc) {
                  final user = User.fromDocument(doc);
                  final searchResult = UserResult(user);
                  searchResults.add(searchResult);
                });
                return ListView(
                  children: searchResults,
                );
              },
            ),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: GestureDetector(
        onTap: () => print('Tapped!'),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
          ),
          title: Text(user.displayName),
          subtitle: Text(user.username),
        ),
      ),
    );
  }
}
