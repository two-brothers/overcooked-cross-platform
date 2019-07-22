class RecipeModel {
    final String id;
    final String title;
    final String imageUrl;

    RecipeModel({
        this.id,
        this.title,
        this.imageUrl
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            id: json['id'],
            title: json['title'],
            imageUrl: json['imageUrl']
        );
    }
}