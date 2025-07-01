import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final List<String> _tags = [
    'Health', 'Spiritual', 'Education', 'Career', 'Vacation', 'Note', 'Thought'
  ];
  String _selectedTag = 'Health'; // default

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final newEntry = JournalEntry(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        timestamp: DateTime.now(),
        tag: _selectedTag,
      );
      Navigator.pop(context, newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter content' : null,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 32),
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
                  child: const Text('Save Note', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
