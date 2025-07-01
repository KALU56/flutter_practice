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
  final ScrollController _tagScrollController = ScrollController();

  final List<String> _filterTags = [
    'All', 'Health', 'Spiritual', 'Education', 'Career',
    'Vacation', 'Note', 'Thought',
  ];

  final Map<String, IconData> _tagIcons = {
    'All': Icons.grid_view,
    'Health': Icons.favorite,
    'Spiritual': Icons.self_improvement,
    'Education': Icons.school,
    'Career': Icons.work,
    'Vacation': Icons.beach_access,
    'Note': Icons.note,
    'Thought': Icons.lightbulb,
  };

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
  void dispose() {
    _tagScrollController.dispose();
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
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'This is my space',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          // Tag selector with left and right scroll buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Scroll left',
                  onPressed: () {
                    _tagScrollController.animateTo(
                      (_tagScrollController.offset - 150).clamp(
                          0.0,
                          _tagScrollController.position.maxScrollExtent
                              .toDouble()),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ListView.separated(
                      controller: _tagScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filterTags.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final tag = _filterTags[index];
                        final isSelected = tag == _selectedFilter;

                        return ChoiceChip(
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _tagIcons[tag],
                                size: 20,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                tag,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.blue.shade50,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedFilter = tag;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Scroll right',
                  onPressed: () {
                    _tagScrollController.animateTo(
                      _tagScrollController.offset + 150,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Entry list
          Expanded(
            child: filteredEntries.isEmpty
                ? const Center(
                    child: Text(
                      'No entries.\nTap + to add a note.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: filteredEntries.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(entry.description,
                                  style:
                                      const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _tagIcons[entry.tag],
                                        size: 16,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '#${entry.tag}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _formatTimestamp(
                                        entry.timestamp),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
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
