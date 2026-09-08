import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saf_stream/saf_stream.dart';
import 'package:saf_util/saf_util.dart';

import '../errors/hush_exception_mapper.dart';

part 'saf_providers.g.dart';

@Riverpod(keepAlive: true)
SafUtil safUtil(Ref ref) => SafUtil();

@Riverpod(keepAlive: true)
SafStream safStream(Ref ref) => SafStream();

@Riverpod(keepAlive: true)
SourceFolderPicker sourceFolderPicker(Ref ref) =>
    SourceFolderPicker(ref.watch(safUtilProvider));

class SourceFolderPicker {
  SourceFolderPicker(this._safUtil);

  final SafUtil _safUtil;

  /// Restituisce l'URI scelto, o null se l'utente annulla.
  ///
  /// `persistablePermission: true` non e opzionale: il lato nativo lo tratta
  /// come false quando manca, e il permesso non sopravvive al riavvio.
  Future<String?> pick() {
    return mapErrors(() async {
      final directory = await _safUtil.pickDirectory(
        writePermission: false,
        persistablePermission: true,
      );
      return directory?.uri;
    });
  }
}
