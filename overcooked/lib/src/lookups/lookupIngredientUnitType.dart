class LookupIngredientUnitType {
    static const _None None = _None(-1, "", "");
    static const _Singular Singular = _Singular(0, " ", " ");
    static const _Grams Grams = _Grams(1, "g ", "g ");
    static const _Millilitres Millilitres = _Millilitres(2, "ml ", "ml ");
    static const _Tsp Tsp = _Tsp(3, " tsp ", " tsp ");
    static const _Tbsp Tbsp = _Tbsp(4, " Tbsp ", " Tbsp ");
    static const _Cups Cups = _Cups(5, " cup ", " cups ");
    static const _Bunch Bunch = _Bunch(6, " bunch of ", " bunches of ");
    static const _Rasher Rasher = _Rasher(7, " rasher of ", " rashes of ");
    static const _Head Head = _Head(8, " head of ", " heads of ");
    static const _Sprig Sprig = _Sprig(9, " sprig of ", " sprigs of ");
    static const _Stalk Stalk = _Stalk(10, " stalk of ", " stalks of ");
    static const _Sheet Sheet = _Sheet(11, " sheet of ", " sheets of ");
    static const _Slice Slice = _Slice(12, " slice of ", " slices of ");
    static const _Kilograms Kilograms = _Kilograms(101, "kg ", "kg ");
    static const _Litres Litres = _Litres(201, "L ", "L ");
}

class _None {
    final int id;
    final String singular;
    final String plural;
    const _None(this.id, this.singular, this.plural);
}

class _Singular {
    final int id;
    final String singular;
    final String plural;
    const _Singular(this.id, this.singular, this.plural);
}

class _Grams {
    final int id;
    final String singular;
    final String plural;
    const _Grams(this.id, this.singular, this.plural);
}

class _Millilitres {
    final int id;
    final String singular;
    final String plural;
    const _Millilitres(this.id, this.singular, this.plural);
}

class _Tsp {
    final int id;
    final String singular;
    final String plural;
    const _Tsp(this.id, this.singular, this.plural);
}

class _Tbsp {
    final int id;
    final String singular;
    final String plural;
    const _Tbsp(this.id, this.singular, this.plural);
}

class _Cups {
    final int id;
    final String singular;
    final String plural;
    const _Cups(this.id, this.singular, this.plural);
}

class _Bunch {
    final int id;
    final String singular;
    final String plural;
    const _Bunch(this.id, this.singular, this.plural);
}

class _Rasher {
    final int id;
    final String singular;
    final String plural;
    const _Rasher(this.id, this.singular, this.plural);
}

class _Head {
    final int id;
    final String singular;
    final String plural;
    const _Head(this.id, this.singular, this.plural);
}

class _Sprig {
    final int id;
    final String singular;
    final String plural;
    const _Sprig(this.id, this.singular, this.plural);
}

class _Stalk {
    final int id;
    final String singular;
    final String plural;
    const _Stalk(this.id, this.singular, this.plural);
}

class _Sheet {
    final int id;
    final String singular;
    final String plural;
    const _Sheet(this.id, this.singular, this.plural);
}

class _Slice {
    final int id;
    final String singular;
    final String plural;
    const _Slice(this.id, this.singular, this.plural);
}

class _Kilograms {
    final int id;
    final String singular;
    final String plural;
    const _Kilograms(this.id, this.singular, this.plural);
}

class _Litres {
    final int id;
    final String singular;
    final String plural;
    const _Litres(this.id, this.singular, this.plural);
}
