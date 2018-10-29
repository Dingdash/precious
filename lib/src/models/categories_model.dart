class CategoryModel{
  final String description;
  final String name;
  final String picture;
  final int category_id;

  CategoryModel.fromJson(Map<String,dynamic>parsedJson)
  :
      description = parsedJson['description'] ?? '',
      name        = parsedJson['name'],
      category_id = parsedJson['category_id'],
      picture = parsedJson['picture']?? '';
  Map <String,dynamic>  toMap(){
    return {
      "category_id":category_id,
      "name":name,
      "picture":picture,
      "description":description,
    };
  }
}