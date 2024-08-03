import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  final String? postId;

  PostForm({this.postId});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.postId != null) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get()
          .then((doc) {
        _titleController.text = doc['title'];
        _contentController.text = doc['content'];
        _typeController.text = doc['type'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postId == null ? '새 게시글' : '게시글 수정'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            // 게시글 유형 선택
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: '게시글 유형'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                final type = _typeController.text;

                if (widget.postId == null) {
                  FirebaseFirestore.instance.collection('posts').add({
                    'title': title,
                    'content': content,
                    'type': type,
                    'createdAt': Timestamp.now(),
                  });
                } else {
                  FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
                    'title': title,
                    'content': content,
                    'type': type,
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text(widget.postId == null ? '게시글 작성' : '게시글 수정'),
            ),
          ],
        ),
      ),
    );
  }
}
