import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../screens/tabs/all_notes_tab.dart';
import '../screens/tabs/sticky_notes_tab.dart';
import '../screens/tabs/template_tab.dart';
import '../screens/add_note_screen.dart';  // Import AddNoteScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Note> notes = [];
  final List<Note> stickyNotes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void addNote(Note note, {bool isSticky = false}) {
    setState(() {
      isSticky ? stickyNotes.add(note) : notes.add(note);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Use direct MaterialPageRoute instead of pushNamed
  void navigateToAddNote({bool isSticky = false}) async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );
    if (newNote != null && newNote is Note) {
      addNote(newNote, isSticky: isSticky);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journal'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Sticky'),
            Tab(text: 'Templates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllNotesTab(notes: notes),
          StickyNotesTab(notes: stickyNotes),
          const TemplatesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddNote(isSticky: _tabController.index == 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
