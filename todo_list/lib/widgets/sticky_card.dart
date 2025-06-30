// lib/widgets/sticky_card.dart
import 'package:flutter/material.dart';
import '../models/note_model.dart';

class StickyNoteCard extends StatelessWidget {
  final Note stickyNote;
  final VoidCallback? onTap;

  const StickyNoteCard({super.key, required this.stickyNote, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[100],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(stickyNote.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          stickyNote.content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}
