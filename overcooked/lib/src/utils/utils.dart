toPrettyStringFraction(double value) {
    final intPart = value.toInt();
    final fractionPart = value - intPart;

    if (fractionPart > 0 && fractionPart < 0.1) return (intPart > 0 ? "$intPart" : "") + "⅒";
    if (fractionPart >= 0.1 && fractionPart < 0.125) return (intPart > 0 ? "$intPart" : "") + "⅛";
    if (fractionPart >= 0.125 && fractionPart < 0.29) return (intPart > 0 ? "$intPart" : "") + "¼";
    if (fractionPart >= 0.29 && fractionPart < 0.415) return (intPart > 0 ? "$intPart" : "") + "⅓";
    if (fractionPart >= 0.415 && fractionPart < 0.58) return (intPart > 0 ? "$intPart" : "") + "½";
    if (fractionPart >= 0.58 && fractionPart < 0.705) return (intPart > 0 ? "$intPart" : "") + "⅔";
    if (fractionPart >= 0.705 && fractionPart < 0.875) return (intPart > 0 ? "$intPart" : "") + "¾";

    return value.round().toString();
}