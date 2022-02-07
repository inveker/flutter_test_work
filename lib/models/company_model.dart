class CompanyModel {
  final String name;
  final String catchPhrase;
  final String bs;

  CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  CompanyModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        catchPhrase = json['catchPhrase'],
        bs = json['bs'];
}
