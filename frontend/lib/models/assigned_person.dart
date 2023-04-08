class AssignedPerson {
  final String avatar;
  final String name;
  final String email;

  static const String FIELD_AVATAR = 'avatar';
  static const String FIELD_NAME = 'name';
  static const String FIELD_EMAIL = 'email';

  const AssignedPerson._({
    required this.avatar,
    required this.name,
    required this.email,
  });

  factory AssignedPerson.fromMap(Map<String, dynamic> map) {
    return AssignedPerson._(
      avatar: map[FIELD_AVATAR],
      name: map[FIELD_NAME],
      email: map[FIELD_EMAIL],
    );
  }
}
