// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerUiState {

 VoiceNote? get note; bool get isLoading; bool get isPlaying; Duration get position; Duration? get duration; double get speed; bool get notificationsBlocked; HushException? get error;
/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUiStateCopyWith<PlayerUiState> get copyWith => _$PlayerUiStateCopyWithImpl<PlayerUiState>(this as PlayerUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUiState&&(identical(other.note, note) || other.note == note)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.notificationsBlocked, notificationsBlocked) || other.notificationsBlocked == notificationsBlocked)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,note,isLoading,isPlaying,position,duration,speed,notificationsBlocked,error);

@override
String toString() {
  return 'PlayerUiState(note: $note, isLoading: $isLoading, isPlaying: $isPlaying, position: $position, duration: $duration, speed: $speed, notificationsBlocked: $notificationsBlocked, error: $error)';
}


}

/// @nodoc
abstract mixin class $PlayerUiStateCopyWith<$Res>  {
  factory $PlayerUiStateCopyWith(PlayerUiState value, $Res Function(PlayerUiState) _then) = _$PlayerUiStateCopyWithImpl;
@useResult
$Res call({
 VoiceNote? note, bool isLoading, bool isPlaying, Duration position, Duration? duration, double speed, bool notificationsBlocked, HushException? error
});


$VoiceNoteCopyWith<$Res>? get note;

}
/// @nodoc
class _$PlayerUiStateCopyWithImpl<$Res>
    implements $PlayerUiStateCopyWith<$Res> {
  _$PlayerUiStateCopyWithImpl(this._self, this._then);

  final PlayerUiState _self;
  final $Res Function(PlayerUiState) _then;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? note = freezed,Object? isLoading = null,Object? isPlaying = null,Object? position = null,Object? duration = freezed,Object? speed = null,Object? notificationsBlocked = null,Object? error = freezed,}) {
  return _then(PlayerUiState(
note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as VoiceNote?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,notificationsBlocked: null == notificationsBlocked ? _self.notificationsBlocked : notificationsBlocked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as HushException?,
  ));
}
/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoiceNoteCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $VoiceNoteCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerUiState].
extension PlayerUiStatePatterns on PlayerUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerUiState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerUiState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoiceNote? note,  bool isLoading,  bool isPlaying,  Duration position,  Duration? duration,  double speed,  bool notificationsBlocked,  HushException? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
return $default(_that.note,_that.isLoading,_that.isPlaying,_that.position,_that.duration,_that.speed,_that.notificationsBlocked,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoiceNote? note,  bool isLoading,  bool isPlaying,  Duration position,  Duration? duration,  double speed,  bool notificationsBlocked,  HushException? error)  $default,) {final _that = this;
switch (_that) {
case _PlayerUiState():
return $default(_that.note,_that.isLoading,_that.isPlaying,_that.position,_that.duration,_that.speed,_that.notificationsBlocked,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoiceNote? note,  bool isLoading,  bool isPlaying,  Duration position,  Duration? duration,  double speed,  bool notificationsBlocked,  HushException? error)?  $default,) {final _that = this;
switch (_that) {
case _PlayerUiState() when $default != null:
return $default(_that.note,_that.isLoading,_that.isPlaying,_that.position,_that.duration,_that.speed,_that.notificationsBlocked,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerUiState extends PlayerUiState {
  const _PlayerUiState({this.note, this.isLoading = false, this.isPlaying = false, this.position = Duration.zero, this.duration, this.speed = 1.0, this.notificationsBlocked = false, this.error}): super._();
  

@override final  VoiceNote? note;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  Duration position;
@override final  Duration? duration;
@override@JsonKey() final  double speed;
@override@JsonKey() final  bool notificationsBlocked;
@override final  HushException? error;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerUiStateCopyWith<_PlayerUiState> get copyWith => __$PlayerUiStateCopyWithImpl<_PlayerUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerUiState&&(identical(other.note, note) || other.note == note)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.notificationsBlocked, notificationsBlocked) || other.notificationsBlocked == notificationsBlocked)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,note,isLoading,isPlaying,position,duration,speed,notificationsBlocked,error);

@override
String toString() {
  return 'PlayerUiState(note: $note, isLoading: $isLoading, isPlaying: $isPlaying, position: $position, duration: $duration, speed: $speed, notificationsBlocked: $notificationsBlocked, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PlayerUiStateCopyWith<$Res> implements $PlayerUiStateCopyWith<$Res> {
  factory _$PlayerUiStateCopyWith(_PlayerUiState value, $Res Function(_PlayerUiState) _then) = __$PlayerUiStateCopyWithImpl;
@override @useResult
$Res call({
 VoiceNote? note, bool isLoading, bool isPlaying, Duration position, Duration? duration, double speed, bool notificationsBlocked, HushException? error
});


@override $VoiceNoteCopyWith<$Res>? get note;

}
/// @nodoc
class __$PlayerUiStateCopyWithImpl<$Res>
    implements _$PlayerUiStateCopyWith<$Res> {
  __$PlayerUiStateCopyWithImpl(this._self, this._then);

  final _PlayerUiState _self;
  final $Res Function(_PlayerUiState) _then;

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? note = freezed,Object? isLoading = null,Object? isPlaying = null,Object? position = null,Object? duration = freezed,Object? speed = null,Object? notificationsBlocked = null,Object? error = freezed,}) {
  return _then(_PlayerUiState(
note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as VoiceNote?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,notificationsBlocked: null == notificationsBlocked ? _self.notificationsBlocked : notificationsBlocked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as HushException?,
  ));
}

/// Create a copy of PlayerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoiceNoteCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $VoiceNoteCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

// dart format on
