import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePost() async {
    final post = {
      'title': titleController.text,
      'price': priceController.text,
      'description': descriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    final postsCollection = FirebaseFirestore.instance.collection('posts');
    final docRef = await postsCollection.add(post);

    if (selectedImage != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images/${docRef.id}.jpg');
      await storageRef.putFile(selectedImage!);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post added successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            selectedImage != null
                ? Image.file(selectedImage!, height: 150)
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _savePost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
