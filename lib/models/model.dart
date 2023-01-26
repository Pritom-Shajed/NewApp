// import 'dart:convert';

// List<NewsApi> newsApiFromJson(String str) =>
//     List<NewsApi>.from(json.decode(str).map((x) => NewsApi.fromJson(x)));

// String newsApiToJson(List<NewsApi> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class NewsApi {
//   NewsApi({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishAt,
//     required this.content,
//   });

//   String source;
//   String author;
//   String title;
//   String description;
//   String url;
//   String urlToImage;
//   String publishAt;
//   String content;

//   factory NewsApi.fromJson(Map<String, dynamic> json) => NewsApi(
//         source: json["source"],
//         author: json["author"],
//         title: json["title"],
//         description: json["description"],
//         url: json["url"],
//         urlToImage: json["urlToImage"],
//         publishAt: json["publishAt"],
//         content: json["content"],
//       );

//   Map<String, dynamic> toJson() => {
//         "albumId": albumId,
//         "id": id,
//         "title": title,
//         "url": url,
//         "thumbnailUrl": thumbnailUrl,
//       };
// }
