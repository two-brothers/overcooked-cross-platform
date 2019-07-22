class RecipeModel {
    final String id;
    final String title;

    RecipeModel({
        this.id,
        this.title
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            id: json['id'],
            title: json['title']
        );
    }
}