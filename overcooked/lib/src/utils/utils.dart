toPrettyStringFraction(double value) {
    final intPart = value.toInt();
    final fractionPart = value - intPart;

    if (fractionPart > 0 && fractionPart < 0.1) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>1</sup>&frasl;<sub>10</sub>";
    if (fractionPart >= 0.1 && fractionPart < 0.125) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>1</sup>&frasl;<sub>8</sub>";
    if (fractionPart >= 0.125 && fractionPart < 0.29) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>1</sup>&frasl;<sub>4</sub>";
    if (fractionPart >= 0.29 && fractionPart < 0.415) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>1</sup>&frasl;<sub>3</sub>";
    if (fractionPart >= 0.415 && fractionPart < 0.58) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>1</sup>&frasl;<sub>2</sub>";
    if (fractionPart >= 0.58 && fractionPart < 0.705) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>2</sup>&frasl;<sub>3</sub>";
    if (fractionPart >= 0.705 && fractionPart < 0.875) return (intPart > 0 ? "$intPart" : "") + "&#65279;<sup>3</sup>&frasl;<sub>4</sub>";

    return value.round().toString();
}