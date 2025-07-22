class UserProfile {
  final String name;
  final String bio;
  final String profileImageUrl;
  final Map<String, String> socialLinks;

  UserProfile({
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.socialLinks,
  });

  UserProfile copyWith({
    String? name,
    String? bio,
    String? profileImageUrl,
    Map<String, String>? socialLinks,
  }) {
    return UserProfile(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      socialLinks: socialLinks ?? Map.from(this.socialLinks),
    );
  }

  bool isEqual(UserProfile other) {
    if (name != other.name || bio != other.bio || profileImageUrl != other.profileImageUrl) {
      return false;
    }
    
    if (socialLinks.length != other.socialLinks.length) {
      return false;
    }
    
    for (String key in socialLinks.keys) {
      if (socialLinks[key] != other.socialLinks[key]) {
        return false;
      }
    }
    
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'socialLinks': socialLinks,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      socialLinks: Map<String, String>.from(json['socialLinks'] ?? {}),
    );
  }
}
