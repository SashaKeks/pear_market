class CustomUserForProductEntity {
  final String userId;
  final String name;
  final String surname;

  CustomUserForProductEntity({
    required this.userId,
    required this.name,
    required this.surname,
  });

  factory CustomUserForProductEntity.empty() {
    return CustomUserForProductEntity(
      userId: "",
      name: "",
      surname: "",
    );
  }
}
