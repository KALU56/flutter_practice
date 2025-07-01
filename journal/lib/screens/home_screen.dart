import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import 'add_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<JournalEntry> _entries = [];
  String _selectedFilter = 'All';

  final List<String> _filterTags = [
    'All', 'Health', 'Spiritual', 'Education', 'Career',
    'Vacation', 'Note', 'Thought'
  ];

  void _addEntry(JournalEntry entry) {
    setState(() {
      _entries.insert(0, entry);
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);
    if (date == today) {
      return 'Today, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _selectedFilter == 'All'
        ? _entries
        : _entries.where((e) => e.tag == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyJournal'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedFilter,
              items: _filterTags.map((tag) {
                return DropdownMenuItem(value: tag, child: Text(tag));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
          ),
          Expanded(
            child: filteredEntries.isEmpty
                ? const Center(
                    child: Text(
                      'No entries.\nTap + to add a note.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEntries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(entry.description, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '#${entry.tag}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    _formatTimestamp(entry.timestamp),
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Entry',
        onPressed: () async {
          final result = await Navigator.push<JournalEntry>(
            context,
            MaterialPageRoute(builder: (_) => const AddEntryScreen()),
          );
          if (result != null) {
            _addEntry(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
