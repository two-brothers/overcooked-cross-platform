class RecipeModel {
    final String title;

    RecipeModel({ this.title });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            title: json['title']
        );
    }
}