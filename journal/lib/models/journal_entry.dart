// lib/models/journal_entry.dart
class JournalEntry {
  final String title;
  final String description;
  final DateTime timestamp; // Added timestamp

  JournalEntry({
    required this.title,
    required this.description,
    required this.timestamp, // Added to constructor
  });
}