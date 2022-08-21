// To parse this JSON data, do
//
//     final score = scoreFromMap(jsonString);

import 'dart:convert';

class Score {
  Score({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.score,
  });

  String? className;
  String? objectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? score;

  factory Score.fromJson(String str) => Score.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Score.fromMap(Map<String, dynamic> json) => Score(
    className: json["className"] == null ? null : json["className"],
    objectId: json["objectId"] == null ? null : json["objectId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    name: json["name"] == null ? null : json["name"],
    score: json["score"] == null ? null : json["score"],
  );

  Map<String, dynamic> toMap() => {
    "className": className == null ? null : className,
    "objectId": objectId == null ? null : objectId,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "name": name == null ? null : name,
    "score": score == null ? null : score,
  };
}
