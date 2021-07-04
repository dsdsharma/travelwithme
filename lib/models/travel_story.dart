enum PostType { text, image }

class TravelStory {
  final String title;
  final String headerImage;
  List<Post> components;

  TravelStory(
      {required this.title,
      required this.headerImage,
      required this.components});

  factory TravelStory.fromJson(Map<String, dynamic> json) {
    return TravelStory(
        title: json['data']['title'] as String,
        headerImage: json['data']['coverUrl'] as String,
        components: fillPosts(json));
  }
}

List<Post> fillPosts(Map<String, dynamic> json) {
  return json['data']['components'].map<Post>((json) {
    return json['type'] == 'image'
        ? Post(
            type: PostType.image,
            title: "",
            description: "",
            image: json['url'])
        : Post(
            type: PostType.text,
            title: json['title'],
            description: json['desc'],
            image: "");
  }).toList();
}

class Post {
  final PostType type;
  final String title;
  final String description;
  final String image;
  Post(
      {required this.type,
      required this.title,
      required this.description,
      required this.image});
}
