import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_post_screen.dart';
import '../widgets/post_list_item.dart';

class BrowsePostsScreen extends StatelessWidget {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Posts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No posts yet!'));
          }

          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index].data() as Map<String, dynamic>;
              return PostListItem(post: post, postId: posts[index].id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new-post');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
