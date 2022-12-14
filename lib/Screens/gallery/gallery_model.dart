// class ImageDetails {
//   String imageId = "";
//   String groupId = "";
//   bool isLiked = false;
//   int likeCount = 0;
//   int commentCount = 0;
//   List<String> likeBy = [];
//   List<Comparable> comment = [];
// }
//
// class CommentDetails {
//   String commentedBy = "";
//   String comment = "";
//   DateTime dateTime = DateTime.now();
// }
class ImageDetails {
  bool liked = false;
  Photos? photos;
  List<DistinctComments> distinctComment = [];

  ImageDetails({required this.liked, this.photos});

  ImageDetails.fromJson(Map<String, dynamic> json) {
    liked = json['liked'];
    photos = json['photos'] != null ? Photos.fromJson(json['photos']) : null;
    if (json['distinctComment'] != null) {
      distinctComment = <DistinctComments>[];
      json['distinctComment'].forEach((v) {
        distinctComment.add(DistinctComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liked'] = this.liked;
    if (this.photos != null) {
      data['photos'] = this.photos!.toJson();
    }
    return data;
  }
}

class Photos {
  String? imageId;
  String? groupId;
  String? imageUrl;
  int likeCount = 0;
  List<LikedBy>? likedBy;
  int commentCount = 0;
  List<CommentData>? commentData;

  Photos({
    this.imageId,
    this.groupId,
    this.imageUrl,
    required this.likeCount,
    this.likedBy,
    required this.commentCount,
    this.commentData,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    imageId = json['_id'];
    groupId = json['groupId'];
    imageUrl = json['imageUrl'];
    likeCount = json['likeCount'];
    if (json['likedBy'] != null) {
      likedBy = <LikedBy>[];
      json['likedBy'].forEach((v) {
        likedBy!.add(LikedBy.fromJson(v));
      });
    }
    commentCount = json['commentCount'];
    if (json['commentData'] != null) {
      commentData = <CommentData>[];
      json['commentData'].forEach((v) {
        commentData!.add(CommentData.fromJson(v));
      });
    }
    // distinctComment = json['distinctComment'];
    //  print('.......' + json.toString());

    // print("distinct comments");
    // print(distinctComment);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.imageId;
    data['groupId'] = this.groupId;
    data['imageUrl'] = this.imageUrl;
    data['likeCount'] = this.likeCount;
    if (this.likedBy != null) {
      data['likedBy'] = this.likedBy!.map((v) => v.toJson()).toList();
    }
    data['commentCount'] = this.commentCount;
    if (this.commentData != null) {
      data['commentData'] = this.commentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistinctComments {
  String? name;
  String? number;
  String? profilePic;

  DistinctComments({this.name, this.number, this.profilePic});

  DistinctComments.fromJson(json) {
    name = json['userName'];
    number = json['mobile'];
    profilePic = json['profileImage'];
    print('...' + json.toString());
    print(name);
    print(number);
    print(profilePic);
  }
}

class LikedBy {
  String? likedNumber;
  String? likedName;
  String? likedProfilePic;
  String? sId;

  LikedBy({this.likedNumber, this.likedName, this.sId, this.likedProfilePic});

  LikedBy.fromJson(Map<String, dynamic> json) {
    likedNumber = json['likedNumber'];
    likedName = json['likedName'];
    sId = json['_id'];
    likedProfilePic = json['likedUserImage'];
    //print(likedProfilePic);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likedNumber'] = this.likedNumber;
    data['likedName'] = this.likedName;
    data['_id'] = this.sId;
    data['likedUserImage'] = this.likedProfilePic;
    return data;
  }
}

class CommentData {
  String? commentedBy;
  String? commented;
  String? sId;
  String? time;
  String? commentedNumber;
  String? commentUserPic;

  CommentData(
      {this.commentedBy,
      this.commented,
      this.sId,
      this.time,
      this.commentedNumber,
      this.commentUserPic});

  CommentData.fromJson(Map<String, dynamic> json) {
    commentedBy = json['commentedBy'];
    commented = json['commented'];
    sId = json['_id'];
    time = json['time'];
    commentedNumber = json['commentedNumber'];
    commentUserPic = json['commentedUserImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentedBy'] = this.commentedBy;
    data['commented'] = this.commented;
    data['_id'] = this.sId;
    data['time'] = this.time;
    data['commentedNumber'] = this.commentedNumber;
    data['commentedUserImage'] = this.commentUserPic;
    return data;
  }
}
