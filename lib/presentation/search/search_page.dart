import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/routes/router.gr.dart';

class SearchPage extends HookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchResultsFuture = useState<Future<QuerySnapshot>?>(null);
    return RefreshIndicator(
      onRefresh: () async {
        searchController.clear();
        searchResultsFuture.value = null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              filled: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              // suffixIcon: IconButton(
              //   icon: const Icon(Icons.clear),
              //   onPressed: () => searchController.clear(),
              // ),
            ),
            onFieldSubmitted: (val) {
              final users = getIt<FirebaseFirestore>()
                  .collection('users')
                  .where("displayName", isGreaterThanOrEqualTo: val)
                  .get();
              searchResultsFuture.value = users;
            },
          ),
        ),
        body: searchResultsFuture.value == null
            // ? const _CenterText()
            ? null
            : _SearchResult(searchResultsFuture: searchResultsFuture.value),
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

// class _CenterText extends StatelessWidget {
//   const _CenterText({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Find Users',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.white,
//           fontStyle: FontStyle.italic,
//           fontWeight: FontWeight.w600,
//           fontSize: 50,
//         ),
//       ),
//     );
//   }
// }

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
