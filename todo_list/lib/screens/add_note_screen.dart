
import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'package:uuid/uuid.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void saveNote() {
    final note = Note(
      id: const Uuid().v4(),
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now(),
    );
    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              child: const Text('Save Note'),
            )
          ],
        ),
      ),
    );
  }
}
