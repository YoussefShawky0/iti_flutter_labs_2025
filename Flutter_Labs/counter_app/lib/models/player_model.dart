import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final int score;

  const Player({required this.id, required this.name, required this.score});

  factory Player.create({required String name, int score = 0}) {
    return Player(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      score: score,
    );
  }

  Player copyWith({String? id, String? name, int? score}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }

  // JSON serialization methods
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score};
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
    );
  }

  @override
  List<Object?> get props => [id, name, score];

  @override
  String toString() => 'Player(id: $id, name: $name, score: $score)';
}
