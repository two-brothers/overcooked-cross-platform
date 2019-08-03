class Food {
    final String id;
    final Name name;
    final List<Conversion> conversions;

    Food({
        this.id,
        this.name,
        this.conversions
    });

    factory Food.fromJson(Map<String, dynamic> json) {
        return Food(
            id: json['id'],
            name: Name.fromJson(json['name']),
            conversions: (json['conversions'] as List).map((i) => Conversion.fromJson(i)).toList()
        );
    }
}

class Name {
    final String singular;
    final String plural;

    Name({
        this.singular,
        this.plural
    });

    factory Name.fromJson(Map<String, dynamic> json) {
        return Name(
            singular: json['singular'],
            plural: json['plural']
        );
    }
}

class Conversion {
    final double ratio;
    final int unitId;

    Conversion({
        this.ratio,
        this.unitId
    });

    factory Conversion.fromJson(Map<String, dynamic> json) {
        return Conversion(
            ratio: json['ratio'].toDouble(),
            unitId: json['unitId']
        );
    }
}