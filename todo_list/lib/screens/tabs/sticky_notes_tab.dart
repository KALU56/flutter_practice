// lib/tabs/sticky_notes_tab.dart
import 'package:flutter/material.dart';
import '../../models/note_model.dart';
import '../../widgets/sticky_card.dart';

class StickyNotesTab extends StatelessWidget {
  final List<Note> notes;

  const StickyNotesTab({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return StickyNoteCard(stickyNote: notes[index]);
      },
    );
  }
}
