class Comment {
  String id;
  String descriptions;

  Comment({required this.id, required this.descriptions});

  factory Comment.toJson(Map<String, dynamic> json) {
    return Comment(id: json['id'], descriptions: json['descriptions']);
  }
}
