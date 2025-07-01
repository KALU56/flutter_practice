import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class AddEntryScreen extends StatefulWidget {
  final JournalEntry? existingEntry;

  const AddEntryScreen({super.key, this.existingEntry});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _sourceController = TextEditingController();
  final _learningController = TextEditingController();

  final List<String> _learnings = [];
  String _selectedTag = 'Health';

  final List<String> _tags = [
    'Health', 'Spiritual', 'Education', 'Career', 'Vacation', 'Note', 'Thought'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      _titleController.text = widget.existingEntry!.title;
      _descController.text = widget.existingEntry!.description;
      _selectedTag = widget.existingEntry!.tag;
      _sourceController.text = widget.existingEntry!.source;
      _learnings.addAll(widget.existingEntry!.learnings);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _sourceController.dispose();
    _learningController.dispose();
    super.dispose();
  }

  void _addLearning() {
    final text = _learningController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _learnings.add(text);
        _learningController.clear();
      });
    }
  }

  void _removeLearning(int index) {
    setState(() {
      _learnings.removeAt(index);
    });
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final newEntry = JournalEntry(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        timestamp: DateTime.now(),
        tag: _selectedTag,
        source: _sourceController.text.trim(),
        learnings: _learnings,
      );
      Navigator.pop(context, newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingEntry != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter content' : null,
              ),
              const SizedBox(height: 16),

              // Source
              TextFormField(
                controller: _sourceController,
                decoration: const InputDecoration(
                  labelText: 'Source (e.g. book, podcast, video)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Tag Dropdown
              DropdownButtonFormField<String>(
                value: _selectedTag,
                decoration: const InputDecoration(
                  labelText: 'Tag (Life Area)',
                  border: OutlineInputBorder(),
                ),
                items: _tags.map((tag) {
                  return DropdownMenuItem(value: tag, child: Text(tag));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTag = value!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // I Learn Today Section
              const Text(
                'I Learn Today',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _learningController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Flutter ListView builder',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addLearning,
                    child: const Text('Add'),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Column(
                children: _learnings.asMap().entries.map((entry) {
                  final index = entry.key;
                  final text = entry.value;
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(text),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeLearning(index),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isEditing ? 'Update Note' : 'Save Note',
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
