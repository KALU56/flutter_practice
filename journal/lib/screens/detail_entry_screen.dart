import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import 'add_entry_screen.dart';

class DetailEntryScreen extends StatelessWidget {
  final JournalEntry entry;
  final Function(JournalEntry) onUpdate;
  final Function() onDelete;

  const DetailEntryScreen({
    super.key,
    required this.entry,
    required this.onUpdate,
    required this.onDelete,
  });

  String _formatTime(DateTime timestamp) {
    return 'Today, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // light background behind tile
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // changed red to blue here too
        title: Text('Entry Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min, // shrink to content height
              children: [
                // Blue header inside tile
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Time
                      Text(
                        entry.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(entry.timestamp),
                            style: const TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          const Spacer(),
                          // Edit and Delete icons inside header
                          GestureDetector(
                            child: const Icon(Icons.edit, color: Colors.white),
                            onTap: () async {
                              final updated = await Navigator.push<JournalEntry>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddEntryScreen(existingEntry: entry),
                                ),
                              );
                              if (updated != null) {
                                onUpdate(updated);
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            child: const Icon(Icons.delete, color: Colors.white),
                            onTap: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Delete Entry'),
                                  content: const Text('Are you sure you want to delete this entry?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed == true) {
                                onDelete();
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Content area inside tile
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tag
                        Text(
                          'Tag: ${entry.tag}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.description,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                        const SizedBox(height: 20),

                        // Source
                        if (entry.source.isNotEmpty) ...[
                          const Text(
                            'Source',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.source,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // I Learn Today
                        if (entry.learnings.isNotEmpty) ...[
                          const Text(
                            'I Learn Today',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: entry.learnings.map((item) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 15, height: 1.5),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
