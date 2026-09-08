// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceNoteId {

 String get fileName; int get sizeBytes;
/// Create a copy of VoiceNoteId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceNoteIdCopyWith<VoiceNoteId> get copyWith => _$VoiceNoteIdCopyWithImpl<VoiceNoteId>(this as VoiceNoteId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceNoteId&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,sizeBytes);

@override
String toString() {
  return 'VoiceNoteId(fileName: $fileName, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $VoiceNoteIdCopyWith<$Res>  {
  factory $VoiceNoteIdCopyWith(VoiceNoteId value, $Res Function(VoiceNoteId) _then) = _$VoiceNoteIdCopyWithImpl;
@useResult
$Res call({
 String fileName, int sizeBytes
});




}
/// @nodoc
class _$VoiceNoteIdCopyWithImpl<$Res>
    implements $VoiceNoteIdCopyWith<$Res> {
  _$VoiceNoteIdCopyWithImpl(this._self, this._then);

  final VoiceNoteId _self;
  final $Res Function(VoiceNoteId) _then;

/// Create a copy of VoiceNoteId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? sizeBytes = null,}) {
  return _then(VoiceNoteId(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceNoteId].
extension VoiceNoteIdPatterns on VoiceNoteId {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceNoteId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceNoteId() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceNoteId value)  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteId():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceNoteId value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteId() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceNoteId() when $default != null:
return $default(_that.fileName,_that.sizeBytes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteId():
return $default(_that.fileName,_that.sizeBytes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteId() when $default != null:
return $default(_that.fileName,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceNoteId extends VoiceNoteId {
  const _VoiceNoteId({required this.fileName, required this.sizeBytes}): super._();
  

@override final  String fileName;
@override final  int sizeBytes;

/// Create a copy of VoiceNoteId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceNoteIdCopyWith<_VoiceNoteId> get copyWith => __$VoiceNoteIdCopyWithImpl<_VoiceNoteId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceNoteId&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,sizeBytes);

@override
String toString() {
  return 'VoiceNoteId(fileName: $fileName, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$VoiceNoteIdCopyWith<$Res> implements $VoiceNoteIdCopyWith<$Res> {
  factory _$VoiceNoteIdCopyWith(_VoiceNoteId value, $Res Function(_VoiceNoteId) _then) = __$VoiceNoteIdCopyWithImpl;
@override @useResult
$Res call({
 String fileName, int sizeBytes
});




}
/// @nodoc
class __$VoiceNoteIdCopyWithImpl<$Res>
    implements _$VoiceNoteIdCopyWith<$Res> {
  __$VoiceNoteIdCopyWithImpl(this._self, this._then);

  final _VoiceNoteId _self;
  final $Res Function(_VoiceNoteId) _then;

/// Create a copy of VoiceNoteId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? sizeBytes = null,}) {
  return _then(_VoiceNoteId(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlaybackProgress {

 Duration get position; Duration? get duration; DateTime? get playedAt;/// Una misura della durata e stata tentata ed e fallita. Serve a non
/// ritentarla a ogni avvio: senza questo, i file che non si riescono a
/// decodificare vengono rimisurati per sempre.
 bool get durationUnavailable;
/// Create a copy of PlaybackProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackProgressCopyWith<PlaybackProgress> get copyWith => _$PlaybackProgressCopyWithImpl<PlaybackProgress>(this as PlaybackProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackProgress&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.durationUnavailable, durationUnavailable) || other.durationUnavailable == durationUnavailable));
}


@override
int get hashCode => Object.hash(runtimeType,position,duration,playedAt,durationUnavailable);

@override
String toString() {
  return 'PlaybackProgress(position: $position, duration: $duration, playedAt: $playedAt, durationUnavailable: $durationUnavailable)';
}


}

/// @nodoc
abstract mixin class $PlaybackProgressCopyWith<$Res>  {
  factory $PlaybackProgressCopyWith(PlaybackProgress value, $Res Function(PlaybackProgress) _then) = _$PlaybackProgressCopyWithImpl;
@useResult
$Res call({
 Duration position, Duration? duration, DateTime? playedAt, bool durationUnavailable
});




}
/// @nodoc
class _$PlaybackProgressCopyWithImpl<$Res>
    implements $PlaybackProgressCopyWith<$Res> {
  _$PlaybackProgressCopyWithImpl(this._self, this._then);

  final PlaybackProgress _self;
  final $Res Function(PlaybackProgress) _then;

/// Create a copy of PlaybackProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? duration = freezed,Object? playedAt = freezed,Object? durationUnavailable = null,}) {
  return _then(PlaybackProgress(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,playedAt: freezed == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationUnavailable: null == durationUnavailable ? _self.durationUnavailable : durationUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackProgress].
extension PlaybackProgressPatterns on PlaybackProgress {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackProgress() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackProgress value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackProgress():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackProgress value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackProgress() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration position,  Duration? duration,  DateTime? playedAt,  bool durationUnavailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackProgress() when $default != null:
return $default(_that.position,_that.duration,_that.playedAt,_that.durationUnavailable);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration position,  Duration? duration,  DateTime? playedAt,  bool durationUnavailable)  $default,) {final _that = this;
switch (_that) {
case _PlaybackProgress():
return $default(_that.position,_that.duration,_that.playedAt,_that.durationUnavailable);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration position,  Duration? duration,  DateTime? playedAt,  bool durationUnavailable)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackProgress() when $default != null:
return $default(_that.position,_that.duration,_that.playedAt,_that.durationUnavailable);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackProgress extends PlaybackProgress {
  const _PlaybackProgress({required this.position, this.duration, this.playedAt, this.durationUnavailable = false}): super._();
  

@override final  Duration position;
@override final  Duration? duration;
@override final  DateTime? playedAt;
/// Una misura della durata e stata tentata ed e fallita. Serve a non
/// ritentarla a ogni avvio: senza questo, i file che non si riescono a
/// decodificare vengono rimisurati per sempre.
@override@JsonKey() final  bool durationUnavailable;

/// Create a copy of PlaybackProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackProgressCopyWith<_PlaybackProgress> get copyWith => __$PlaybackProgressCopyWithImpl<_PlaybackProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackProgress&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.durationUnavailable, durationUnavailable) || other.durationUnavailable == durationUnavailable));
}


@override
int get hashCode => Object.hash(runtimeType,position,duration,playedAt,durationUnavailable);

@override
String toString() {
  return 'PlaybackProgress(position: $position, duration: $duration, playedAt: $playedAt, durationUnavailable: $durationUnavailable)';
}


}

/// @nodoc
abstract mixin class _$PlaybackProgressCopyWith<$Res> implements $PlaybackProgressCopyWith<$Res> {
  factory _$PlaybackProgressCopyWith(_PlaybackProgress value, $Res Function(_PlaybackProgress) _then) = __$PlaybackProgressCopyWithImpl;
@override @useResult
$Res call({
 Duration position, Duration? duration, DateTime? playedAt, bool durationUnavailable
});




}
/// @nodoc
class __$PlaybackProgressCopyWithImpl<$Res>
    implements _$PlaybackProgressCopyWith<$Res> {
  __$PlaybackProgressCopyWithImpl(this._self, this._then);

  final _PlaybackProgress _self;
  final $Res Function(_PlaybackProgress) _then;

/// Create a copy of PlaybackProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? duration = freezed,Object? playedAt = freezed,Object? durationUnavailable = null,}) {
  return _then(_PlaybackProgress(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,playedAt: freezed == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationUnavailable: null == durationUnavailable ? _self.durationUnavailable : durationUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$VoiceNote {

 VoiceNoteId get id; String get sourceUri; DateTime get receivedAt; DateTime? get nameDay; int? get sequence; PlaybackProgress? get progress;
/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceNoteCopyWith<VoiceNote> get copyWith => _$VoiceNoteCopyWithImpl<VoiceNote>(this as VoiceNote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceNote&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceUri, sourceUri) || other.sourceUri == sourceUri)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.nameDay, nameDay) || other.nameDay == nameDay)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,sourceUri,receivedAt,nameDay,sequence,progress);

@override
String toString() {
  return 'VoiceNote(id: $id, sourceUri: $sourceUri, receivedAt: $receivedAt, nameDay: $nameDay, sequence: $sequence, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $VoiceNoteCopyWith<$Res>  {
  factory $VoiceNoteCopyWith(VoiceNote value, $Res Function(VoiceNote) _then) = _$VoiceNoteCopyWithImpl;
@useResult
$Res call({
 VoiceNoteId id, String sourceUri, DateTime receivedAt, DateTime? nameDay, int? sequence, PlaybackProgress? progress
});


$VoiceNoteIdCopyWith<$Res> get id;$PlaybackProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class _$VoiceNoteCopyWithImpl<$Res>
    implements $VoiceNoteCopyWith<$Res> {
  _$VoiceNoteCopyWithImpl(this._self, this._then);

  final VoiceNote _self;
  final $Res Function(VoiceNote) _then;

/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sourceUri = null,Object? receivedAt = null,Object? nameDay = freezed,Object? sequence = freezed,Object? progress = freezed,}) {
  return _then(VoiceNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as VoiceNoteId,sourceUri: null == sourceUri ? _self.sourceUri : sourceUri // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,nameDay: freezed == nameDay ? _self.nameDay : nameDay // ignore: cast_nullable_to_non_nullable
as DateTime?,sequence: freezed == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as PlaybackProgress?,
  ));
}
/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoiceNoteIdCopyWith<$Res> get id {
  
  return $VoiceNoteIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $PlaybackProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [VoiceNote].
extension VoiceNotePatterns on VoiceNote {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceNote() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceNote value)  $default,){
final _that = this;
switch (_that) {
case _VoiceNote():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceNote value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceNote() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoiceNoteId id,  String sourceUri,  DateTime receivedAt,  DateTime? nameDay,  int? sequence,  PlaybackProgress? progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceNote() when $default != null:
return $default(_that.id,_that.sourceUri,_that.receivedAt,_that.nameDay,_that.sequence,_that.progress);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoiceNoteId id,  String sourceUri,  DateTime receivedAt,  DateTime? nameDay,  int? sequence,  PlaybackProgress? progress)  $default,) {final _that = this;
switch (_that) {
case _VoiceNote():
return $default(_that.id,_that.sourceUri,_that.receivedAt,_that.nameDay,_that.sequence,_that.progress);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoiceNoteId id,  String sourceUri,  DateTime receivedAt,  DateTime? nameDay,  int? sequence,  PlaybackProgress? progress)?  $default,) {final _that = this;
switch (_that) {
case _VoiceNote() when $default != null:
return $default(_that.id,_that.sourceUri,_that.receivedAt,_that.nameDay,_that.sequence,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceNote extends VoiceNote {
  const _VoiceNote({required this.id, required this.sourceUri, required this.receivedAt, this.nameDay, this.sequence, this.progress}): super._();
  

@override final  VoiceNoteId id;
@override final  String sourceUri;
@override final  DateTime receivedAt;
@override final  DateTime? nameDay;
@override final  int? sequence;
@override final  PlaybackProgress? progress;

/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceNoteCopyWith<_VoiceNote> get copyWith => __$VoiceNoteCopyWithImpl<_VoiceNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceNote&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceUri, sourceUri) || other.sourceUri == sourceUri)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.nameDay, nameDay) || other.nameDay == nameDay)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,sourceUri,receivedAt,nameDay,sequence,progress);

@override
String toString() {
  return 'VoiceNote(id: $id, sourceUri: $sourceUri, receivedAt: $receivedAt, nameDay: $nameDay, sequence: $sequence, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$VoiceNoteCopyWith<$Res> implements $VoiceNoteCopyWith<$Res> {
  factory _$VoiceNoteCopyWith(_VoiceNote value, $Res Function(_VoiceNote) _then) = __$VoiceNoteCopyWithImpl;
@override @useResult
$Res call({
 VoiceNoteId id, String sourceUri, DateTime receivedAt, DateTime? nameDay, int? sequence, PlaybackProgress? progress
});


@override $VoiceNoteIdCopyWith<$Res> get id;@override $PlaybackProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class __$VoiceNoteCopyWithImpl<$Res>
    implements _$VoiceNoteCopyWith<$Res> {
  __$VoiceNoteCopyWithImpl(this._self, this._then);

  final _VoiceNote _self;
  final $Res Function(_VoiceNote) _then;

/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sourceUri = null,Object? receivedAt = null,Object? nameDay = freezed,Object? sequence = freezed,Object? progress = freezed,}) {
  return _then(_VoiceNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as VoiceNoteId,sourceUri: null == sourceUri ? _self.sourceUri : sourceUri // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,nameDay: freezed == nameDay ? _self.nameDay : nameDay // ignore: cast_nullable_to_non_nullable
as DateTime?,sequence: freezed == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as PlaybackProgress?,
  ));
}

/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoiceNoteIdCopyWith<$Res> get id {
  
  return $VoiceNoteIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of VoiceNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $PlaybackProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
