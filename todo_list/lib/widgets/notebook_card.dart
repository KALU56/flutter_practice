// lib/widgets/notebook_card.dart
import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotebookCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;

  const NotebookCard({super.key, required this.note, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '${note.createdAt.month}/${note.createdAt.day}/${note.createdAt.year}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}