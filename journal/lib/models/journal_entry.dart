class JournalEntry {
  final String title;
  final String description;
  final DateTime timestamp;
  final String tag; // new field

  JournalEntry({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.tag,
  });
}
