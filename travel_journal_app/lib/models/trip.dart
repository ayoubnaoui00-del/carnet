class Trip {
  final int id;
  final String title;
  final String destination;
  final String startDate;
  final String endDate;
  final String notes;
  final String? imageUrl;

  const Trip({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.notes,
    this.imageUrl,
  });

  static String _formatDate(dynamic value) {
    if (value == null) return '';
    final str = value.toString().trim();
    if (str.isEmpty) return '';
    final dt = DateTime.tryParse(str);
    if (dt != null) {
      return '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    }
    return str.split('T')[0];
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      title: (json['title'] ?? '') as String,
      destination: (json['destination'] ?? '') as String,
      startDate: _formatDate(json['start_date'] ?? json['startDate']),
      endDate: _formatDate(json['end_date'] ?? json['endDate']),
      notes: (json['notes'] ?? '') as String,
      imageUrl: json['image_url'] as String? ?? json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'notes': notes,
      if (imageUrl != null && imageUrl!.isNotEmpty) 'imageUrl': imageUrl,
    };
  }

  Trip copyWith({
    int? id,
    String? title,
    String? destination,
    String? startDate,
    String? endDate,
    String? notes,
    String? imageUrl,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
