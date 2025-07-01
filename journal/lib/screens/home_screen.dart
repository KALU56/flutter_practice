import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import 'add_entry_screen.dart';
import 'detail_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<JournalEntry> _entries = [];
  String _selectedFilter = 'All';
  final ScrollController _tagScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filterTags = [
    'All', 'Health', 'Spiritual', 'Education', 'Career',
    'Vacation', 'Note', 'Thought',
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

    if (date == today) return 'Today';

    const monthNames = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return '${timestamp.day} ${monthNames[timestamp.month]}';
  }

  @override
  void dispose() {
    _tagScrollController.dispose();
    _searchController.dispose();
    super.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search journal...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                // Optional: Add search filter logic here
              },
            ),
          ),

          // Tag Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    _tagScrollController.animateTo(
                      (_tagScrollController.offset - 100).clamp(
                        0.0,
                        _tagScrollController.position.maxScrollExtent,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      controller: _tagScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _filterTags.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final tag = _filterTags[index];
                        final isSelected = tag == _selectedFilter;
                        return ChoiceChip(
                          label: Text(tag),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              _selectedFilter = tag;
                            });
                          },
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    _tagScrollController.animateTo(
                      _tagScrollController.offset + 100,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Entry List
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredEntries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailEntryScreen(
                                entry: entry,
                                onUpdate: (updatedEntry) {
                                  setState(() {
                                    _entries[index] = updatedEntry;
                                  });
                                },
                                onDelete: () {
                                  setState(() {
                                    _entries.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.tag.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  entry.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  entry.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    _formatTimestamp(entry.timestamp),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Add Button
      floatingActionButton: FloatingActionButton(
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
