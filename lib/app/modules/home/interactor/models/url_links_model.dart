class UrlLinksModel {
  final String? self;
  final String? short;

  UrlLinksModel({this.self, this.short});

  factory UrlLinksModel.fromJson(Map<String, dynamic> json) {
    return UrlLinksModel(self: json['self'] ?? '', short: json['short'] ?? '');
  }

  factory UrlLinksModel.empty() => UrlLinksModel(self: '', short: '');

  Map<String, dynamic> toJson() {
    return {'self': self, 'short': short};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UrlLinksModel &&
      other.self == self &&
      other.short == short;
  }

  @override
  int get hashCode => self.hashCode ^ short.hashCode;
}
