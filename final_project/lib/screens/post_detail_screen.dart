import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  final String postId;

  PostDetailScreen({required this.post, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${post['title']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Price: \$${post['price']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Description: ${post['description']}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
