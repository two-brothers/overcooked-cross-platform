class LookupIngredientType {
    static const _Quantified QUANTIFIED = _Quantified(0);
    static const _FreeText FREE_TEXT = _FreeText(1);
}

class _Quantified {
    final int id;
    const _Quantified(this.id);
}

class _FreeText {
    final int id;
    const _FreeText(this.id);
}