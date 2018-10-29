import 'dart:convert';
class ProductsModel{
  final String Product_ID;
  final String Category_ID;
  final String Product_name;
  final String Product_cover;
  final String Additional_product_cover;
  final List<VariantModel> variant;

  ProductsModel.fromJson(Map<String,dynamic>parsedJson)
  : Product_ID = parsedJson['Product_ID'].toString(),
        Category_ID = parsedJson['Category_ID'].toString(),
        Product_name = parsedJson['Product_name'],
        Product_cover = parsedJson['Product_cover'],
        Additional_product_cover = parsedJson['Additional_product_cover'],
        variant = (parsedJson['variant'] as List).map((i)=>VariantModel.fromJson(i)).toList();




}
class VariantModel{
  final String Product_ID;
  final String Specification_ID;

  final String Specification_name;
  final String Specification_price;
  final List<SpecificationModel> specifications;
  VariantModel.fromJson(Map<String,dynamic>parsedJson)
  :Product_ID = parsedJson['Product_ID'].toString(),
        Specification_ID = parsedJson['Specification_ID'].toString(),
        Specification_name = parsedJson['Specification_name'],
        Specification_price = parsedJson['Specification_price'].toString(),
        specifications =(parsedJson['Specifications'] as List).map((i)=>SpecificationModel.fromJson(i)).toList();
}
class SpecificationModel{
  final String Specification_ID;
  final String name;
  final String value;
  SpecificationModel.fromJson(Map<String,dynamic>parsedJson)
  :Specification_ID = parsedJson['Specification_ID'],
  name = parsedJson['name'],
  value = parsedJson['value'];

}