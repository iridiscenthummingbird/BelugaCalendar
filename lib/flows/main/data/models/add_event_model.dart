class AddEventModel {
  AddEventModel({
    required this.ownerId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.dateTime,
  });

  final String ownerId;
  final String title;
  final String description;
  final String categoryId;
  final DateTime dateTime;
}
