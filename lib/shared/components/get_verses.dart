String getVerseEndSymbol(int verseNumber, {bool arabicNumeral = true}) {
  var arabicNumeric = '';
  var digits = verseNumber.toString().split("").toList();

  if (!arabicNumeral) return '\u06dd${verseNumber.toString()}';

  for (var e in digits) {
    if (e == "0") {
      arabicNumeric += "٠";
    }
    if (e == "1") {
      arabicNumeric += "۱";
    }
    if (e == "2") {
      arabicNumeric += "۲";
    }
    if (e == "3") {
      arabicNumeric += "۳";
    }
    if (e == "4") {
      arabicNumeric += "٤";
    }
    if (e == "5") {
      arabicNumeric += "٥";
    }
    if (e == "6") {
      arabicNumeric += "٦";
    }
    if (e == "7") {
      arabicNumeric += "۷";
    }
    if (e == "8") {
      arabicNumeric += "۸";
    }
    if (e == "9") {
      arabicNumeric += "۹";
    }
  }

  return '\u06dd$arabicNumeric';
}
