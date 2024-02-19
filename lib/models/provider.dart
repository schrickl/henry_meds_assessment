class Provider {
  String id;
  List<DateTime?> openDates;

  // Constructor
  Provider({this.id = "Provider1", this.openDates = const []});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      openDates: json['openDates'] == null
          ? []
          : (json['openDates'] as List)
              .map((e) => e == null ? null : DateTime.parse(e as String))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'openDates': openDates.map((e) => e?.toIso8601String()).toList(),
    };
  }

  @override
  String toString() {
    return 'Provider{id: $id, openDates: $openDates}';
  }
}