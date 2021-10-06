import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';
import 'package:flutter_share/injection.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<QuerySnapshot>? searchResultsFuture;

  final searchController = TextEditingController();

  void clearForm() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        clearForm();
        setState(() {
          searchResultsFuture = null;
        });
      },
      child: Scaffold(
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
              final users = getIt<FirebaseFirestore>()
                  .collection('users')
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
                    return Center(child: CircularProgressIndicator());
                  }
                  final List<UserResult> searchResults = [];
                  snapshot.data!.docs.forEach(
                    (doc) {
                      final userJson = doc.data() as Map<String, dynamic>;
                      final user = User.fromJson(userJson);
                      // User.fromDocument(doc as DocumentSnapshot<Object>);
                      final searchResult = UserResult(user);
                      searchResults.add(searchResult);
                    },
                  );
                  return ListView(
                    children: searchResults,
                  );
                },
              ),
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
        onTap: () {
          context.pushRoute(ProfileRoute(id: user.id));
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
