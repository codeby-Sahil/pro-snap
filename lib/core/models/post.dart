class FeedModel {
  String? id;
  UserId? userId;
  String? caption;
  List<Media>? media;
  dynamic location;
  List<dynamic>? hashtags;
  int? likesCount;
  int? commentsCount;
  bool? isArchived;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? liked;

  FeedModel({
    this.id,
    this.userId,
    this.caption,
    this.media,
    this.location,
    this.hashtags,
    this.likesCount,
    this.commentsCount,
    this.isArchived,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.liked,
  });

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["userId"] is Map) {
      userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
    }
    if (json["caption"] is String) {
      caption = json["caption"];
    }
    if (json["media"] is List) {
      media =
          json["media"] == null
              ? null
              : (json["media"] as List).map((e) => Media.fromJson(e)).toList();
    }
    location = json["location"];
    if (json["hashtags"] is List) {
      hashtags = json["hashtags"] ?? [];
    }
    if (json["likesCount"] is int) {
      likesCount = json["likesCount"];
    }
    if (json["commentsCount"] is int) {
      commentsCount = json["commentsCount"];
    }
    if (json["isArchived"] is bool) {
      isArchived = json["isArchived"];
    }
    if (json["isDeleted"] is bool) {
      isDeleted = json["isDeleted"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
    if (json["liked"] is bool) {
      liked = json["liked"];
    }
  }

  static List<FeedModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(FeedModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if (userId != null) {
      _data["userId"] = userId?.toJson();
    }
    _data["caption"] = caption;
    if (media != null) {
      _data["media"] = media?.map((e) => e.toJson()).toList();
    }
    _data["location"] = location;
    if (hashtags != null) {
      _data["hashtags"] = hashtags;
    }
    _data["likesCount"] = likesCount;
    _data["commentsCount"] = commentsCount;
    _data["isArchived"] = isArchived;
    _data["isDeleted"] = isDeleted;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    _data["liked"] = liked;
    return _data;
  }
}

class Media {
  String? url;
  String? type;
  String? id;

  Media({this.url, this.type, this.id});

  Media.fromJson(Map<String, dynamic> json) {
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
  }

  static List<Media> fromList(List<Map<String, dynamic>> list) {
    return list.map(Media.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["type"] = type;
    _data["_id"] = id;
    return _data;
  }
}

class UserId {
  String? id;
  String? userName;
  dynamic profilePicture;
  bool? isVerified;
  String? name;

  UserId({
    this.id,
    this.userName,
    this.profilePicture,
    this.isVerified,
    this.name,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
    profilePicture = json["profilePicture"];
    if (json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  static List<UserId> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserId.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userName"] = userName;
    _data["profilePicture"] = profilePicture;
    _data["isVerified"] = isVerified;
    _data["name"] = name;
    return _data;
  }
}
