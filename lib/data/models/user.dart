class AppUser {
  final String info;

  AppUser({required this.info});

  Map<String, dynamic> toMap() {
    return {
      'info': info,
    };
  }

  AppUser.fromMap(Map<String, dynamic> appUserMap) : info = appUserMap["info"];
}
