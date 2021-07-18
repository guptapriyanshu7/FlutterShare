import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/application/post/post_bloc.dart';
import 'package:flutter_share/domain/auth/user.dart';
import 'package:flutter_share/injection.dart';
import 'package:flutter_share/presentation/profile/widgets/single_post.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>()..add(PostEvent.read()),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          print('object');
          return state.maybeMap(
            readFailure: (state) {
              print('readFailure');
              return Text('');
            },
            readSuccess: (state) => Scaffold(
              appBar: AppBar(
                title: Text('Flutter Share'),
              ),
              body: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (_, index) {
                  final post = state.posts[index];
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: getIt<FirebaseFirestore>()
                        .collection('users')
                        .doc(post.ownerid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userDoc = snapshot.data!;
                        final userJson = userDoc.data();
                        final user = User.fromJson(userJson!);
                        return SinglePost(post, user);
                      } else
                        return Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ),
            orElse: () => CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
