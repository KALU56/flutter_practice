
import 'package:flutter/material.dart';
import '../../models/note_model.dart';
import '../../widgets/notebook_card.dart';

class AllNotesTab extends StatelessWidget {
  final List<Note> notes;

  const AllNotesTab({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NotebookCard(note: notes[index]);
      },
    );
  }
}
