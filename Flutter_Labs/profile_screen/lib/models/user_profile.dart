class UserProfile {
  String name;
  String bio;
  String facebook;
  String twitter;
  String instagram;
  String? profileImagePath;

  UserProfile({
    required this.name,
    required this.bio,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    this.profileImagePath,
  });

  factory UserProfile.initial() {
    return UserProfile(
      name: 'Youssef Shawky',
      bio: 'Flutter Developer',
      facebook: 'www.facebook.com/youssef.shawky',
      twitter: 'www.twitter.com/youssef_shawky',
      instagram: 'www.instagram.com/youssef.shawky',
      profileImagePath: null,
    );
  }
}
