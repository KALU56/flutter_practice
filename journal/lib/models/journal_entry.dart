class JournalEntry {
  final String title;
  final String description;
  final DateTime timestamp;
  final String tag;
  final String source;
  final List<String> learnings;

  JournalEntry({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.tag,
    required this.source,
    required this.learnings,
  });
}
