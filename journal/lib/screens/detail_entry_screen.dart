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
    final month = _monthName(timestamp.month);
    return 'Today, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')} • $month';
  }

  String _monthName(int monthNumber) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[monthNumber - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,  // Blue background for header
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 8),

                  // Title + time vertically stacked
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 18, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(
                              _formatTime(entry.timestamp),
                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Edit button
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 26),
                    onPressed: () async {
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

                  // Delete button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white, size: 26),
                    onPressed: () async {
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
            ),
          ),

          // Content container with curved top corners
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Source (if available)
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

                    // I Learn Today (if available)
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
          ),
        ],
      ),
    );
  }
}
