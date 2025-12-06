// http://www.crumlin.dk/geocaching/gade/#:~:text=A%20Gade%20is%20a%20method%2C%20invented%20by%20the,least%20one%20variable%20containing%20each%20digit%20%28including%20zero%29.
// https://gcwiki.dk/doku.php?id=gade_beregningsteknik
// https://gcwiki.dk/doku.php?id=edag_beregningsteknik&s%5b%5d=gade
// https://gcwiki.dk/doku.php?id=lowe_beregningsteknik
// https://gcwiki.dk/doku.php?id=ewol

enum GADE_TYPES {GADE, EDAG, LOWE, EWOL}

Map<GADE_TYPES, String> gadeTypes = {
  GADE_TYPES.GADE: 'GADE',
  GADE_TYPES.EDAG: 'EDAG',
  GADE_TYPES.LOWE: 'LOWE',
  GADE_TYPES.EWOL: 'EWOL',
};

Map<String, String> calculateGade(GADE_TYPES type, String input){
  switch (type) {
    case GADE_TYPES.GADE: return buildGade(input);
    case GADE_TYPES.EDAG: return buildGade(input);
    case GADE_TYPES.LOWE: return buildGade(input);
    case GADE_TYPES.EWOL: return buildGade(input);
  }
}

Map<String, String> buildEdag(String input) {
  return {};
}

Map<String, String> buildEwol(String input) {
  return {};
}

Map<String, String> buildLowe(String input) {
  return {};
}

Map<String, String> buildGade(String input) {
  var outputList = <String>[];
  var gadeMap = <String, String>{};

  outputList = input.replaceAll(RegExp(r'\D'), '').split('');
  outputList.sort();

  for (int index = 0; index <= 9; index++) {
    if (!outputList.contains(index.toString())) {
      outputList.add(index.toString());
    }
  }

  for (int index = 0; index < outputList.length; index++) {
    if (index < 26) {
      gadeMap[String.fromCharCode(index + 65)] = outputList[index];
    }
  }

  return gadeMap;
}
