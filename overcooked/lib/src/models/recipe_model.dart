class RecipeModel {
    final String id;
    final String title;
    final String imageUrl;
    final int serves;
    final int makes;
    final int prepTime;
    final int cookTime;
    final List<String> method;

    RecipeModel({
        this.id,
        this.title,
        this.imageUrl,
        this.serves,
        this.makes,
        this.prepTime,
        this.cookTime,
        this.method,
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            id: json['id'],
            title: json['title'],
            imageUrl: json['imageUrl'],
            serves: json['serves'],
            makes: json['makes'],
            prepTime: json['prepTime'],
            cookTime: json['cookTime'],
            method: json['method'].cast<String>()
        );
    }
}