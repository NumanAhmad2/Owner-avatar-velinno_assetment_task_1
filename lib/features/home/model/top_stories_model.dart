import 'dart:convert';

TopStoriesModel topStoriesModelFromJson(String str) =>
    TopStoriesModel.fromJson(json.decode(str));

String topStoriesModelToJson(TopStoriesModel data) =>
    json.encode(data.toJson());

class TopStoriesModel {
  String status;
  String copyright;
  String section;
  DateTime lastUpdated;
  int numResults;
  List<Result> results;

  TopStoriesModel({
    required this.status,
    required this.copyright,
    required this.section,
    required this.lastUpdated,
    required this.numResults,
    required this.results,
  });

  factory TopStoriesModel.fromJson(Map<String, dynamic> json) =>
      TopStoriesModel(
        status: json["status"],
        copyright: json["copyright"],
        section: json["section"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        numResults: json["num_results"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "copyright": copyright,
    "section": section,
    "last_updated": lastUpdated.toIso8601String(),
    "num_results": numResults,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String section;
  String subsection;
  String title;
  String resultAbstract;
  String url;
  String uri;
  String byline;
  ItemType itemType;
  DateTime updatedDate;
  DateTime createdDate;
  DateTime publishedDate;
  String materialTypeFacet;
  Kicker kicker;
  List<String> desFacet;
  List<String> orgFacet;
  List<String> perFacet;
  List<String> geoFacet;
  List<Multimedia> multimedia;
  String shortUrl;

  Result({
    required this.section,
    required this.subsection,
    required this.title,
    required this.resultAbstract,
    required this.url,
    required this.uri,
    required this.byline,
    required this.itemType,
    required this.updatedDate,
    required this.createdDate,
    required this.publishedDate,
    required this.materialTypeFacet,
    required this.kicker,
    required this.desFacet,
    required this.orgFacet,
    required this.perFacet,
    required this.geoFacet,
    required this.multimedia,
    required this.shortUrl,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    section: json["section"],
    subsection: json["subsection"],
    title: json["title"],
    resultAbstract: json["abstract"],
    url: json["url"],
    uri: json["uri"],
    byline: json["byline"],
    itemType: itemTypeValues.map[json["item_type"]]!,
    updatedDate: DateTime.parse(json["updated_date"]),
    createdDate: DateTime.parse(json["created_date"]),
    publishedDate: DateTime.parse(json["published_date"]),
    materialTypeFacet: json["material_type_facet"],
    kicker: kickerValues.map[json["kicker"]]!,
    desFacet: List<String>.from(json["des_facet"].map((x) => x)),
    orgFacet: List<String>.from(json["org_facet"].map((x) => x)),
    perFacet: List<String>.from(json["per_facet"].map((x) => x)),
    geoFacet: List<String>.from(json["geo_facet"].map((x) => x)),
    multimedia: List<Multimedia>.from(
      json["multimedia"].map((x) => Multimedia.fromJson(x)),
    ),
    shortUrl: json["short_url"],
  );

  Map<String, dynamic> toJson() => {
    "section": section,
    "subsection": subsection,
    "title": title,
    "abstract": resultAbstract,
    "url": url,
    "uri": uri,
    "byline": byline,
    "item_type": itemTypeValues.reverse[itemType],
    "updated_date": updatedDate.toIso8601String(),
    "created_date": createdDate.toIso8601String(),
    "published_date": publishedDate.toIso8601String(),
    "material_type_facet": materialTypeFacet,
    "kicker": kickerValues.reverse[kicker],
    "des_facet": List<dynamic>.from(desFacet.map((x) => x)),
    "org_facet": List<dynamic>.from(orgFacet.map((x) => x)),
    "per_facet": List<dynamic>.from(perFacet.map((x) => x)),
    "geo_facet": List<dynamic>.from(geoFacet.map((x) => x)),
    "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
    "short_url": shortUrl,
  };
}

enum ItemType { article, interactive }

final itemTypeValues = EnumValues({
  "Article": ItemType.article,
  "Interactive": ItemType.interactive,
});

enum Kicker { criticsNotebook, empty, fallPreview, nonfiction }

final kickerValues = EnumValues({
  "Critic’s Notebook": Kicker.criticsNotebook,
  "": Kicker.empty,
  "Fall Preview": Kicker.fallPreview,
  "Nonfiction": Kicker.nonfiction,
});

class Multimedia {
  String url;
  Format format;
  int height;
  int width;
  Type type;
  Subtype subtype;
  String caption;
  String copyright;

  Multimedia({
    required this.url,
    required this.format,
    required this.height,
    required this.width,
    required this.type,
    required this.subtype,
    required this.caption,
    required this.copyright,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
    url: json["url"],
    format: formatValues.map[json["format"]]!,
    height: json["height"],
    width: json["width"],
    type: typeValues.map[json["type"]]!,
    subtype: subtypeValues.map[json["subtype"]]!,
    caption: json["caption"],
    copyright: json["copyright"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "format": formatValues.reverse[format],
    "height": height,
    "width": width,
    "type": typeValues.reverse[type],
    "subtype": subtypeValues.reverse[subtype],
    "caption": caption,
    "copyright": copyright,
  };
}

enum Format { largeThumbnail, superJumbo, threeByTwoSmallAt2X }

final formatValues = EnumValues({
  "Large Thumbnail": Format.largeThumbnail,
  "Super Jumbo": Format.superJumbo,
  "threeByTwoSmallAt2X": Format.threeByTwoSmallAt2X,
});

enum Subtype { photo }

final subtypeValues = EnumValues({"photo": Subtype.photo});

enum Type { image }

final typeValues = EnumValues({"image": Type.image});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
