
class Story {
  User? user;
  List<Stories>? stories;

  Story({this.user, this.stories});

  Story.fromJson(Map<String, dynamic> json) {
    if(json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if(json["stories"] is List) {
      stories = json["stories"] == null ? null : (json["stories"] as List).map((e) => Stories.fromJson(e)).toList();
    }
  }

  static List<Story> fromList(List<Map<String, dynamic>> list) {
    return list.map(Story.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    if(stories != null) {
      _data["stories"] = stories?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Stories {
  Media? media;
  String? id;
  UserId? userId;
  String? caption;
  int? viewsCount;
  bool? isArchived;
  bool? isDeleted;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? viewed;

  Stories({this.media, this.id, this.userId, this.caption, this.viewsCount, this.isArchived, this.isDeleted, this.expiresAt, this.createdAt, this.updatedAt, this.v, this.viewed});

  Stories.fromJson(Map<String, dynamic> json) {
    if(json["media"] is Map) {
      media = json["media"] == null ? null : Media.fromJson(json["media"]);
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["userId"] is Map) {
      userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
    }
    if(json["caption"] is String) {
      caption = json["caption"];
    }
    if(json["viewsCount"] is int) {
      viewsCount = json["viewsCount"];
    }
    if(json["isArchived"] is bool) {
      isArchived = json["isArchived"];
    }
    if(json["isDeleted"] is bool) {
      isDeleted = json["isDeleted"];
    }
    if(json["expiresAt"] is String) {
      expiresAt = json["expiresAt"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
    if(json["viewed"] is bool) {
      viewed = json["viewed"];
    }
  }

  static List<Stories> fromList(List<Map<String, dynamic>> list) {
    return list.map(Stories.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(media != null) {
      _data["media"] = media?.toJson();
    }
    _data["_id"] = id;
    if(userId != null) {
      _data["userId"] = userId?.toJson();
    }
    _data["caption"] = caption;
    _data["viewsCount"] = viewsCount;
    _data["isArchived"] = isArchived;
    _data["isDeleted"] = isDeleted;
    _data["expiresAt"] = expiresAt;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    _data["viewed"] = viewed;
    return _data;
  }
}

class UserId {
  String? id;
  String? userName;
  String? name;
  String? profilePicture;
  bool? isVerified;

  UserId({this.id, this.userName, this.name, this.profilePicture, this.isVerified});

  UserId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["userName"] is String) {
      userName = json["userName"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["profilePicture"] is String) {
      profilePicture = json["profilePicture"];
    }
    if(json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
  }

  static List<UserId> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserId.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userName"] = userName;
    _data["name"] = name;
    _data["profilePicture"] = profilePicture;
    _data["isVerified"] = isVerified;
    return _data;
  }
}

class Media {
  String? url;
  String? type;

  Media({this.url, this.type});

  Media.fromJson(Map<String, dynamic> json) {
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
  }

  static List<Media> fromList(List<Map<String, dynamic>> list) {
    return list.map(Media.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["type"] = type;
    return _data;
  }
}

class User {
  String? id;
  String? userName;
  String? name;
  String? profilePicture;
  bool? isVerified;

  User({this.id, this.userName, this.name, this.profilePicture, this.isVerified});

  User.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["userName"] is String) {
      userName = json["userName"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["profilePicture"] is String) {
      profilePicture = json["profilePicture"];
    }
    if(json["isVerified"] is bool) {
      isVerified = json["isVerified"];
    }
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userName"] = userName;
    _data["name"] = name;
    _data["profilePicture"] = profilePicture;
    _data["isVerified"] = isVerified;
    return _data;
  }
}