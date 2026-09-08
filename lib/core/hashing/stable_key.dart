import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Digest stabile tra esecuzioni, usato dove serve un identificatore opaco al
/// posto del nome di un vocale: nomi di file in cache e id della sessione
/// media. Una sostituzione di caratteri non basta, perche mappa nomi diversi
/// sulla stessa stringa e fa collidere due vocali distinti.
String stableKey(String input) =>
    sha256.convert(utf8.encode(input)).toString().substring(0, 32);
