import 'package:flutter/material.dart';
import '../screens/post_detail_screen.dart';

class PostListItem extends StatelessWidget {
  final Map<String, dynamic> post;
  final String postId;

  PostListItem({required this.post, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post['title']),
      subtitle: Text('\$${post['price']}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: post, postId: postId),
          ),
        );
      },
    );
  }
}
