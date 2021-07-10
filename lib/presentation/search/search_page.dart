import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/models/user.dart';
import 'package:flutter_share/presentation/profile/profile_page.dart';
import 'package:flutter_share/widgets/progress.dart';

class SearchPage extends StatelessWidget {
  Future<QuerySnapshot>? searchResultsFuture;
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
            prefixIcon: const Icon(Icons.account_box),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: clearForm,
            ),
          ),
          onFieldSubmitted: (val) {
            // final users = usersRef
            //     .where("displayName", isGreaterThanOrEqualTo: val)
            //     .get();
            // setState(() {
            //   searchResultsFuture = users;
            // });
          },
        ),
      ),
      body: searchResultsFuture == null
          ? Center(
              child: ListView(
                shrinkWrap: true,
                children: const [
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
              builder:
                  (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (!snapshot.hasData) {
                  return circularIndicator();
                }
                final List<UserResult> searchResults = [];
                snapshot.data!.docs.forEach(
                  (doc) {
                    final user =
                        User.fromDocument(doc as DocumentSnapshot<Object>);
                    final searchResult = UserResult(user);
                    searchResults.add(searchResult);
                  },
                );
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
  const UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                print(user.displayName);
                return ProfilePage(user.id);
              },
            ),
          );
        },
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