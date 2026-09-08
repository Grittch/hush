// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_note_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceNoteGroup {

 DateTime get day; List<VoiceNote> get notes;
/// Create a copy of VoiceNoteGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceNoteGroupCopyWith<VoiceNoteGroup> get copyWith => _$VoiceNoteGroupCopyWithImpl<VoiceNoteGroup>(this as VoiceNoteGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceNoteGroup&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other.notes, notes));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(notes));

@override
String toString() {
  return 'VoiceNoteGroup(day: $day, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $VoiceNoteGroupCopyWith<$Res>  {
  factory $VoiceNoteGroupCopyWith(VoiceNoteGroup value, $Res Function(VoiceNoteGroup) _then) = _$VoiceNoteGroupCopyWithImpl;
@useResult
$Res call({
 DateTime day, List<VoiceNote> notes
});




}
/// @nodoc
class _$VoiceNoteGroupCopyWithImpl<$Res>
    implements $VoiceNoteGroupCopyWith<$Res> {
  _$VoiceNoteGroupCopyWithImpl(this._self, this._then);

  final VoiceNoteGroup _self;
  final $Res Function(VoiceNoteGroup) _then;

/// Create a copy of VoiceNoteGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? notes = null,}) {
  return _then(VoiceNoteGroup(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<VoiceNote>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceNoteGroup].
extension VoiceNoteGroupPatterns on VoiceNoteGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceNoteGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceNoteGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceNoteGroup value)  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceNoteGroup value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceNoteGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  List<VoiceNote> notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceNoteGroup() when $default != null:
return $default(_that.day,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  List<VoiceNote> notes)  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteGroup():
return $default(_that.day,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  List<VoiceNote> notes)?  $default,) {final _that = this;
switch (_that) {
case _VoiceNoteGroup() when $default != null:
return $default(_that.day,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceNoteGroup implements VoiceNoteGroup {
  const _VoiceNoteGroup({required this.day, required  List<VoiceNote> notes}): _notes = notes;
  

@override final  DateTime day;
 final  List<VoiceNote> _notes;
@override List<VoiceNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}


/// Create a copy of VoiceNoteGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceNoteGroupCopyWith<_VoiceNoteGroup> get copyWith => __$VoiceNoteGroupCopyWithImpl<_VoiceNoteGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceNoteGroup&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other._notes, _notes));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(_notes));

@override
String toString() {
  return 'VoiceNoteGroup(day: $day, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$VoiceNoteGroupCopyWith<$Res> implements $VoiceNoteGroupCopyWith<$Res> {
  factory _$VoiceNoteGroupCopyWith(_VoiceNoteGroup value, $Res Function(_VoiceNoteGroup) _then) = __$VoiceNoteGroupCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, List<VoiceNote> notes
});




}
/// @nodoc
class __$VoiceNoteGroupCopyWithImpl<$Res>
    implements _$VoiceNoteGroupCopyWith<$Res> {
  __$VoiceNoteGroupCopyWithImpl(this._self, this._then);

  final _VoiceNoteGroup _self;
  final $Res Function(_VoiceNoteGroup) _then;

/// Create a copy of VoiceNoteGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? notes = null,}) {
  return _then(_VoiceNoteGroup(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<VoiceNote>,
  ));
}


}

// dart format on
