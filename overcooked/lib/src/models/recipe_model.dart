class RecipeModel {
    final String id;
    final String title;
    final String imageUrl;
    final List<String> method;

    RecipeModel({
        this.id,
        this.title,
        this.imageUrl,
        this.method
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            id: json['id'],
            title: json['title'],
            imageUrl: json['imageUrl'],
            method: json['method'].cast<String>()
        );
    }
}