import '../models/note_model.dart';
import '../models/template_model.dart';

final List<Note> dummyNotes = [
  Note(
    id: 'n1',
    title: 'First Note',
    content: 'This is the content of the first note.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Note(
    id: 'n2',
    title: 'Second Note',
    content: 'Some sticky note content here.',
    createdAt: DateTime.now(),
  ),
];

final List<Note> dummyStickyNotes = [
  Note(
    id: 's1',
    title: 'Sticky Note 1',
    content: 'Remember to buy milk.',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
];

final List<Template> dummyTemplates = [
  Template(
    id: 't1',
    title: 'Daily Reflection',
    description: 'A template to write about your day.',
  ),
  Template(
    id: 't2',
    title: 'Idea Capture',
    description: 'Template to quickly jot down ideas.',
  ),
];
