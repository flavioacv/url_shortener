import 'package:url_shortener/app/modules/home/interactor/models/url_links_model.dart';

class ShortenedUrlModel {
  final String? alias;
  final UrlLinksModel? links;

  ShortenedUrlModel({this.alias, this.links});

  factory ShortenedUrlModel.fromJson(Map<String, dynamic> json) {
    return ShortenedUrlModel(
      alias: json['alias'] ?? '',
      links: json['_links'] != null
          ? UrlLinksModel.fromJson(json['_links'])
          : UrlLinksModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'alias': alias, '_links': links?.toJson()};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShortenedUrlModel &&
        other.alias == alias &&
        other.links == links;
  }

  @override
  int get hashCode => alias.hashCode ^ links.hashCode;
}
