import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<QuerySnapshot>? searchResultsFuture;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        searchController.clear();
        setState(() {
          searchResultsFuture = null;
        });
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                onPressed: () => searchController.clear(),
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
            ? const _CenterText()
            : _SearchResult(searchResultsFuture: searchResultsFuture),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    Key? key,
    required this.searchResultsFuture,
  }) : super(key: key);

  final Future<QuerySnapshot>? searchResultsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<UserResult> searchResults = [];
        for (final doc in snapshot.data!.docs) {
          final userJson = doc.data()! as Map<String, dynamic>;
          final user = User.fromJson(userJson);
          final searchResult = UserResult(user);
          searchResults.add(searchResult);
        }
        return ListView(
          children: searchResults,
        );
      },
    );
  }
}

class _CenterText extends StatelessWidget {
  const _CenterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Find Users',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          fontSize: 50,
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
