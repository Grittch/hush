import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'hush_database.g.dart';

class PlaybackStates extends Table {
  TextColumn get fileName => text()();
  IntColumn get sizeBytes => integer()();
  IntColumn get positionMs => integer().withDefault(const Constant(0))();
  IntColumn get durationMs => integer().nullable()();
  BoolColumn get durationUnavailable =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get playedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {fileName, sizeBytes};
}

@DriftDatabase(tables: [PlaybackStates])
class HushDatabase extends _$HushDatabase {
  HushDatabase() : super(driftDatabase(name: 'hush'));

  HushDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      // v2 aggiunge `durationUnavailable`: senza questa migrazione le
      // installazioni esistenti si romperebbero all'avvio.
      if (from < 2) {
        await migrator.addColumn(
          playbackStates,
          playbackStates.durationUnavailable,
        );
      }
    },
  );
}
