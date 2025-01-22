// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FilesdbTable extends Filesdb with TableInfo<$FilesdbTable, FilesdbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilesdbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, mimeType, size, path, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'filesdb';
  @override
  VerificationContext validateIntegrity(Insertable<FilesdbData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilesdbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilesdbData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
    );
  }

  @override
  $FilesdbTable createAlias(String alias) {
    return $FilesdbTable(attachedDatabase, alias);
  }
}

class FilesdbData extends DataClass implements Insertable<FilesdbData> {
  final int id;
  final String mimeType;
  final int size;
  final String path;
  final int? duration;
  const FilesdbData(
      {required this.id,
      required this.mimeType,
      required this.size,
      required this.path,
      this.duration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mime_type'] = Variable<String>(mimeType);
    map['size'] = Variable<int>(size);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    return map;
  }

  FilesdbCompanion toCompanion(bool nullToAbsent) {
    return FilesdbCompanion(
      id: Value(id),
      mimeType: Value(mimeType),
      size: Value(size),
      path: Value(path),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
    );
  }

  factory FilesdbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilesdbData(
      id: serializer.fromJson<int>(json['id']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      size: serializer.fromJson<int>(json['size']),
      path: serializer.fromJson<String>(json['path']),
      duration: serializer.fromJson<int?>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mimeType': serializer.toJson<String>(mimeType),
      'size': serializer.toJson<int>(size),
      'path': serializer.toJson<String>(path),
      'duration': serializer.toJson<int?>(duration),
    };
  }

  FilesdbData copyWith(
          {int? id,
          String? mimeType,
          int? size,
          String? path,
          Value<int?> duration = const Value.absent()}) =>
      FilesdbData(
        id: id ?? this.id,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
        path: path ?? this.path,
        duration: duration.present ? duration.value : this.duration,
      );
  FilesdbData copyWithCompanion(FilesdbCompanion data) {
    return FilesdbData(
      id: data.id.present ? data.id.value : this.id,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      size: data.size.present ? data.size.value : this.size,
      path: data.path.present ? data.path.value : this.path,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilesdbData(')
          ..write('id: $id, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('path: $path, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mimeType, size, path, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilesdbData &&
          other.id == this.id &&
          other.mimeType == this.mimeType &&
          other.size == this.size &&
          other.path == this.path &&
          other.duration == this.duration);
}

class FilesdbCompanion extends UpdateCompanion<FilesdbData> {
  final Value<int> id;
  final Value<String> mimeType;
  final Value<int> size;
  final Value<String> path;
  final Value<int?> duration;
  const FilesdbCompanion({
    this.id = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.size = const Value.absent(),
    this.path = const Value.absent(),
    this.duration = const Value.absent(),
  });
  FilesdbCompanion.insert({
    this.id = const Value.absent(),
    required String mimeType,
    required int size,
    required String path,
    this.duration = const Value.absent(),
  })  : mimeType = Value(mimeType),
        size = Value(size),
        path = Value(path);
  static Insertable<FilesdbData> custom({
    Expression<int>? id,
    Expression<String>? mimeType,
    Expression<int>? size,
    Expression<String>? path,
    Expression<int>? duration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mimeType != null) 'mime_type': mimeType,
      if (size != null) 'size': size,
      if (path != null) 'path': path,
      if (duration != null) 'duration': duration,
    });
  }

  FilesdbCompanion copyWith(
      {Value<int>? id,
      Value<String>? mimeType,
      Value<int>? size,
      Value<String>? path,
      Value<int?>? duration}) {
    return FilesdbCompanion(
      id: id ?? this.id,
      mimeType: mimeType ?? this.mimeType,
      size: size ?? this.size,
      path: path ?? this.path,
      duration: duration ?? this.duration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesdbCompanion(')
          ..write('id: $id, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('path: $path, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSaveChatsMeta =
      const VerificationMeta('isSaveChats');
  @override
  late final GeneratedColumn<bool> isSaveChats = GeneratedColumn<bool>(
      'is_save_chats', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_save_chats" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _photoIdMeta =
      const VerificationMeta('photoId');
  @override
  late final GeneratedColumn<int> photoId = GeneratedColumn<int>(
      'photo_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES filesdb (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, description, isSaveChats, photoId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_save_chats')) {
      context.handle(
          _isSaveChatsMeta,
          isSaveChats.isAcceptableOrUnknown(
              data['is_save_chats']!, _isSaveChatsMeta));
    }
    if (data.containsKey('photo_id')) {
      context.handle(_photoIdMeta,
          photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isSaveChats: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_save_chats'])!,
      photoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}photo_id']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String description;
  final bool isSaveChats;
  final int? photoId;
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.description,
      required this.isSaveChats,
      this.photoId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['description'] = Variable<String>(description);
    map['is_save_chats'] = Variable<bool>(isSaveChats);
    if (!nullToAbsent || photoId != null) {
      map['photo_id'] = Variable<int>(photoId);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      description: Value(description),
      isSaveChats: Value(isSaveChats),
      photoId: photoId == null && nullToAbsent
          ? const Value.absent()
          : Value(photoId),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      description: serializer.fromJson<String>(json['description']),
      isSaveChats: serializer.fromJson<bool>(json['isSaveChats']),
      photoId: serializer.fromJson<int?>(json['photoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'description': serializer.toJson<String>(description),
      'isSaveChats': serializer.toJson<bool>(isSaveChats),
      'photoId': serializer.toJson<int?>(photoId),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          String? email,
          String? description,
          bool? isSaveChats,
          Value<int?> photoId = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        description: description ?? this.description,
        isSaveChats: isSaveChats ?? this.isSaveChats,
        photoId: photoId.present ? photoId.value : this.photoId,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      description:
          data.description.present ? data.description.value : this.description,
      isSaveChats:
          data.isSaveChats.present ? data.isSaveChats.value : this.isSaveChats,
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('description: $description, ')
          ..write('isSaveChats: $isSaveChats, ')
          ..write('photoId: $photoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, email, description, isSaveChats, photoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.description == this.description &&
          other.isSaveChats == this.isSaveChats &&
          other.photoId == this.photoId);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> description;
  final Value<bool> isSaveChats;
  final Value<int?> photoId;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.description = const Value.absent(),
    this.isSaveChats = const Value.absent(),
    this.photoId = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String description,
    this.isSaveChats = const Value.absent(),
    this.photoId = const Value.absent(),
  })  : name = Value(name),
        email = Value(email),
        description = Value(description);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? description,
    Expression<bool>? isSaveChats,
    Expression<int>? photoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (description != null) 'description': description,
      if (isSaveChats != null) 'is_save_chats': isSaveChats,
      if (photoId != null) 'photo_id': photoId,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? description,
      Value<bool>? isSaveChats,
      Value<int?>? photoId}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      isSaveChats: isSaveChats ?? this.isSaveChats,
      photoId: photoId ?? this.photoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isSaveChats.present) {
      map['is_save_chats'] = Variable<bool>(isSaveChats.value);
    }
    if (photoId.present) {
      map['photo_id'] = Variable<int>(photoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('description: $description, ')
          ..write('isSaveChats: $isSaveChats, ')
          ..write('photoId: $photoId')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  const Category({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category copyWith({int? id, String? name}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, userId, createdAt, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final int id;
  final String title;
  final int? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Chat(
      {required this.id,
      required this.title,
      this.userId,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      title: Value(title),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Chat copyWith(
          {int? id,
          String? title,
          Value<int?> userId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Chat(
        id: id ?? this.id,
        title: title ?? this.title,
        userId: userId.present ? userId.value : this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, userId, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.title == this.title &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  ChatsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Chat> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  ChatsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int?>? userId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return ChatsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chats (id)'));
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isBotMeta = const VerificationMeta('isBot');
  @override
  late final GeneratedColumn<bool> isBot = GeneratedColumn<bool>(
      'is_bot', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_bot" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, chatId, messageText, createdAt, updatedAt, isBot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_messageTextMeta,
          messageText.isAcceptableOrUnknown(data['text']!, _messageTextMeta));
    } else if (isInserting) {
      context.missing(_messageTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_bot')) {
      context.handle(
          _isBotMeta, isBot.isAcceptableOrUnknown(data['is_bot']!, _isBotMeta));
    } else if (isInserting) {
      context.missing(_isBotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isBot: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bot'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final int chatId;
  final String messageText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isBot;
  const Message(
      {required this.id,
      required this.chatId,
      required this.messageText,
      required this.createdAt,
      required this.updatedAt,
      required this.isBot});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['text'] = Variable<String>(messageText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_bot'] = Variable<bool>(isBot);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      chatId: Value(chatId),
      messageText: Value(messageText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isBot: Value(isBot),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      messageText: serializer.fromJson<String>(json['messageText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isBot: serializer.fromJson<bool>(json['isBot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'messageText': serializer.toJson<String>(messageText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isBot': serializer.toJson<bool>(isBot),
    };
  }

  Message copyWith(
          {int? id,
          int? chatId,
          String? messageText,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isBot}) =>
      Message(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        messageText: messageText ?? this.messageText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isBot: isBot ?? this.isBot,
      );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      messageText:
          data.messageText.present ? data.messageText.value : this.messageText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isBot: data.isBot.present ? data.isBot.value : this.isBot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageText: $messageText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isBot: $isBot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chatId, messageText, createdAt, updatedAt, isBot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.messageText == this.messageText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isBot == this.isBot);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> messageText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isBot;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.messageText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isBot = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String messageText,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required bool isBot,
  })  : chatId = Value(chatId),
        messageText = Value(messageText),
        isBot = Value(isBot);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? messageText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isBot,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (messageText != null) 'text': messageText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isBot != null) 'is_bot': isBot,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? chatId,
      Value<String>? messageText,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isBot}) {
    return MessagesCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      messageText: messageText ?? this.messageText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isBot: isBot ?? this.isBot,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (messageText.present) {
      map['text'] = Variable<String>(messageText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isBot.present) {
      map['is_bot'] = Variable<bool>(isBot.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageText: $messageText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isBot: $isBot')
          ..write(')'))
        .toString();
  }
}

class $CategoryChatTable extends CategoryChat
    with TableInfo<$CategoryChatTable, CategoryChatData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryChatTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chats (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, chatId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_chat';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryChatData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryChatData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryChatData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
    );
  }

  @override
  $CategoryChatTable createAlias(String alias) {
    return $CategoryChatTable(attachedDatabase, alias);
  }
}

class CategoryChatData extends DataClass
    implements Insertable<CategoryChatData> {
  final int id;
  final int categoryId;
  final int chatId;
  const CategoryChatData(
      {required this.id, required this.categoryId, required this.chatId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['chat_id'] = Variable<int>(chatId);
    return map;
  }

  CategoryChatCompanion toCompanion(bool nullToAbsent) {
    return CategoryChatCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      chatId: Value(chatId),
    );
  }

  factory CategoryChatData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryChatData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      chatId: serializer.fromJson<int>(json['chatId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'chatId': serializer.toJson<int>(chatId),
    };
  }

  CategoryChatData copyWith({int? id, int? categoryId, int? chatId}) =>
      CategoryChatData(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        chatId: chatId ?? this.chatId,
      );
  CategoryChatData copyWithCompanion(CategoryChatCompanion data) {
    return CategoryChatData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryChatData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, chatId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryChatData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.chatId == this.chatId);
}

class CategoryChatCompanion extends UpdateCompanion<CategoryChatData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<int> chatId;
  const CategoryChatCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.chatId = const Value.absent(),
  });
  CategoryChatCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int chatId,
  })  : categoryId = Value(categoryId),
        chatId = Value(chatId);
  static Insertable<CategoryChatData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? chatId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (chatId != null) 'chat_id': chatId,
    });
  }

  CategoryChatCompanion copyWith(
      {Value<int>? id, Value<int>? categoryId, Value<int>? chatId}) {
    return CategoryChatCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryChatCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }
}

class $FileMessageTable extends FileMessage
    with TableInfo<$FileMessageTable, FileMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileMessageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
      'message_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES messages (id)'));
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
      'file_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, messageId, fileId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_message';
  @override
  VerificationContext validateIntegrity(Insertable<FileMessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileMessageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_id'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_id'])!,
    );
  }

  @override
  $FileMessageTable createAlias(String alias) {
    return $FileMessageTable(attachedDatabase, alias);
  }
}

class FileMessageData extends DataClass implements Insertable<FileMessageData> {
  final int id;
  final int messageId;
  final String fileId;
  const FileMessageData(
      {required this.id, required this.messageId, required this.fileId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<int>(messageId);
    map['file_id'] = Variable<String>(fileId);
    return map;
  }

  FileMessageCompanion toCompanion(bool nullToAbsent) {
    return FileMessageCompanion(
      id: Value(id),
      messageId: Value(messageId),
      fileId: Value(fileId),
    );
  }

  factory FileMessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileMessageData(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<int>(json['messageId']),
      fileId: serializer.fromJson<String>(json['fileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<int>(messageId),
      'fileId': serializer.toJson<String>(fileId),
    };
  }

  FileMessageData copyWith({int? id, int? messageId, String? fileId}) =>
      FileMessageData(
        id: id ?? this.id,
        messageId: messageId ?? this.messageId,
        fileId: fileId ?? this.fileId,
      );
  FileMessageData copyWithCompanion(FileMessageCompanion data) {
    return FileMessageData(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileMessageData(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('fileId: $fileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, fileId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileMessageData &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.fileId == this.fileId);
}

class FileMessageCompanion extends UpdateCompanion<FileMessageData> {
  final Value<int> id;
  final Value<int> messageId;
  final Value<String> fileId;
  const FileMessageCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.fileId = const Value.absent(),
  });
  FileMessageCompanion.insert({
    this.id = const Value.absent(),
    required int messageId,
    required String fileId,
  })  : messageId = Value(messageId),
        fileId = Value(fileId);
  static Insertable<FileMessageData> custom({
    Expression<int>? id,
    Expression<int>? messageId,
    Expression<String>? fileId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (fileId != null) 'file_id': fileId,
    });
  }

  FileMessageCompanion copyWith(
      {Value<int>? id, Value<int>? messageId, Value<String>? fileId}) {
    return FileMessageCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      fileId: fileId ?? this.fileId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<String>(fileId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileMessageCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('fileId: $fileId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FilesdbTable filesdb = $FilesdbTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $CategoryChatTable categoryChat = $CategoryChatTable(this);
  late final $FileMessageTable fileMessage = $FileMessageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [filesdb, users, categories, chats, messages, categoryChat, fileMessage];
}

typedef $$FilesdbTableCreateCompanionBuilder = FilesdbCompanion Function({
  Value<int> id,
  required String mimeType,
  required int size,
  required String path,
  Value<int?> duration,
});
typedef $$FilesdbTableUpdateCompanionBuilder = FilesdbCompanion Function({
  Value<int> id,
  Value<String> mimeType,
  Value<int> size,
  Value<String> path,
  Value<int?> duration,
});

final class $$FilesdbTableReferences
    extends BaseReferences<_$AppDatabase, $FilesdbTable, FilesdbData> {
  $$FilesdbTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsersTable, List<User>> _usersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.users,
          aliasName: $_aliasNameGenerator(db.filesdb.id, db.users.photoId));

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.photoId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FilesdbTableFilterComposer
    extends Composer<_$AppDatabase, $FilesdbTable> {
  $$FilesdbTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  Expression<bool> usersRefs(
      Expression<bool> Function($$UsersTableFilterComposer f) f) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.photoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FilesdbTableOrderingComposer
    extends Composer<_$AppDatabase, $FilesdbTable> {
  $$FilesdbTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));
}

class $$FilesdbTableAnnotationComposer
    extends Composer<_$AppDatabase, $FilesdbTable> {
  $$FilesdbTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  Expression<T> usersRefs<T extends Object>(
      Expression<T> Function($$UsersTableAnnotationComposer a) f) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.photoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FilesdbTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FilesdbTable,
    FilesdbData,
    $$FilesdbTableFilterComposer,
    $$FilesdbTableOrderingComposer,
    $$FilesdbTableAnnotationComposer,
    $$FilesdbTableCreateCompanionBuilder,
    $$FilesdbTableUpdateCompanionBuilder,
    (FilesdbData, $$FilesdbTableReferences),
    FilesdbData,
    PrefetchHooks Function({bool usersRefs})> {
  $$FilesdbTableTableManager(_$AppDatabase db, $FilesdbTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilesdbTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilesdbTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilesdbTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<int> size = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int?> duration = const Value.absent(),
          }) =>
              FilesdbCompanion(
            id: id,
            mimeType: mimeType,
            size: size,
            path: path,
            duration: duration,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mimeType,
            required int size,
            required String path,
            Value<int?> duration = const Value.absent(),
          }) =>
              FilesdbCompanion.insert(
            id: id,
            mimeType: mimeType,
            size: size,
            path: path,
            duration: duration,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FilesdbTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({usersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (usersRefs) db.users],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$FilesdbTableReferences._usersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FilesdbTableReferences(db, table, p0).usersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.photoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FilesdbTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FilesdbTable,
    FilesdbData,
    $$FilesdbTableFilterComposer,
    $$FilesdbTableOrderingComposer,
    $$FilesdbTableAnnotationComposer,
    $$FilesdbTableCreateCompanionBuilder,
    $$FilesdbTableUpdateCompanionBuilder,
    (FilesdbData, $$FilesdbTableReferences),
    FilesdbData,
    PrefetchHooks Function({bool usersRefs})>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  required String description,
  Value<bool> isSaveChats,
  Value<int?> photoId,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> description,
  Value<bool> isSaveChats,
  Value<int?> photoId,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FilesdbTable _photoIdTable(_$AppDatabase db) => db.filesdb
      .createAlias($_aliasNameGenerator(db.users.photoId, db.filesdb.id));

  $$FilesdbTableProcessedTableManager? get photoId {
    if ($_item.photoId == null) return null;
    final manager = $$FilesdbTableTableManager($_db, $_db.filesdb)
        .filter((f) => f.id($_item.photoId!));
    final item = $_typedResult.readTableOrNull(_photoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ChatsTable, List<Chat>> _chatsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.chats,
          aliasName: $_aliasNameGenerator(db.users.id, db.chats.userId));

  $$ChatsTableProcessedTableManager get chatsRefs {
    final manager = $$ChatsTableTableManager($_db, $_db.chats)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_chatsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSaveChats => $composableBuilder(
      column: $table.isSaveChats, builder: (column) => ColumnFilters(column));

  $$FilesdbTableFilterComposer get photoId {
    final $$FilesdbTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $db.filesdb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilesdbTableFilterComposer(
              $db: $db,
              $table: $db.filesdb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> chatsRefs(
      Expression<bool> Function($$ChatsTableFilterComposer f) f) {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableFilterComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSaveChats => $composableBuilder(
      column: $table.isSaveChats, builder: (column) => ColumnOrderings(column));

  $$FilesdbTableOrderingComposer get photoId {
    final $$FilesdbTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $db.filesdb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilesdbTableOrderingComposer(
              $db: $db,
              $table: $db.filesdb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isSaveChats => $composableBuilder(
      column: $table.isSaveChats, builder: (column) => column);

  $$FilesdbTableAnnotationComposer get photoId {
    final $$FilesdbTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $db.filesdb,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilesdbTableAnnotationComposer(
              $db: $db,
              $table: $db.filesdb,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> chatsRefs<T extends Object>(
      Expression<T> Function($$ChatsTableAnnotationComposer a) f) {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableAnnotationComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool photoId, bool chatsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isSaveChats = const Value.absent(),
            Value<int?> photoId = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            email: email,
            description: description,
            isSaveChats: isSaveChats,
            photoId: photoId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            required String description,
            Value<bool> isSaveChats = const Value.absent(),
            Value<int?> photoId = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            email: email,
            description: description,
            isSaveChats: isSaveChats,
            photoId: photoId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({photoId = false, chatsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chatsRefs) db.chats],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (photoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.photoId,
                    referencedTable: $$UsersTableReferences._photoIdTable(db),
                    referencedColumn:
                        $$UsersTableReferences._photoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._chatsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).chatsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool photoId, bool chatsRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoryChatTable, List<CategoryChatData>>
      _categoryChatRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.categoryChat,
              aliasName: $_aliasNameGenerator(
                  db.categories.id, db.categoryChat.categoryId));

  $$CategoryChatTableProcessedTableManager get categoryChatRefs {
    final manager = $$CategoryChatTableTableManager($_db, $_db.categoryChat)
        .filter((f) => f.categoryId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoryChatRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> categoryChatRefs(
      Expression<bool> Function($$CategoryChatTableFilterComposer f) f) {
    final $$CategoryChatTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categoryChat,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryChatTableFilterComposer(
              $db: $db,
              $table: $db.categoryChat,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> categoryChatRefs<T extends Object>(
      Expression<T> Function($$CategoryChatTableAnnotationComposer a) f) {
    final $$CategoryChatTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categoryChat,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryChatTableAnnotationComposer(
              $db: $db,
              $table: $db.categoryChat,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool categoryChatRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryChatRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (categoryChatRefs) db.categoryChat],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryChatRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoriesTableReferences
                            ._categoryChatRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .categoryChatRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool categoryChatRefs})>;
typedef $$ChatsTableCreateCompanionBuilder = ChatsCompanion Function({
  Value<int> id,
  required String title,
  Value<int?> userId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$ChatsTableUpdateCompanionBuilder = ChatsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int?> userId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$ChatsTableReferences
    extends BaseReferences<_$AppDatabase, $ChatsTable, Chat> {
  $$ChatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.chats.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.messages,
          aliasName: $_aliasNameGenerator(db.chats.id, db.messages.chatId));

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager($_db, $_db.messages)
        .filter((f) => f.chatId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CategoryChatTable, List<CategoryChatData>>
      _categoryChatRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.categoryChat,
          aliasName: $_aliasNameGenerator(db.chats.id, db.categoryChat.chatId));

  $$CategoryChatTableProcessedTableManager get categoryChatRefs {
    final manager = $$CategoryChatTableTableManager($_db, $_db.categoryChat)
        .filter((f) => f.chatId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_categoryChatRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChatsTableFilterComposer extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> messagesRefs(
      Expression<bool> Function($$MessagesTableFilterComposer f) f) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.chatId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> categoryChatRefs(
      Expression<bool> Function($$CategoryChatTableFilterComposer f) f) {
    final $$CategoryChatTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categoryChat,
        getReferencedColumn: (t) => t.chatId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryChatTableFilterComposer(
              $db: $db,
              $table: $db.categoryChat,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChatsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> messagesRefs<T extends Object>(
      Expression<T> Function($$MessagesTableAnnotationComposer a) f) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.chatId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> categoryChatRefs<T extends Object>(
      Expression<T> Function($$CategoryChatTableAnnotationComposer a) f) {
    final $$CategoryChatTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.categoryChat,
        getReferencedColumn: (t) => t.chatId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryChatTableAnnotationComposer(
              $db: $db,
              $table: $db.categoryChat,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatsTable,
    Chat,
    $$ChatsTableFilterComposer,
    $$ChatsTableOrderingComposer,
    $$ChatsTableAnnotationComposer,
    $$ChatsTableCreateCompanionBuilder,
    $$ChatsTableUpdateCompanionBuilder,
    (Chat, $$ChatsTableReferences),
    Chat,
    PrefetchHooks Function(
        {bool userId, bool messagesRefs, bool categoryChatRefs})> {
  $$ChatsTableTableManager(_$AppDatabase db, $ChatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ChatsCompanion(
            id: id,
            title: title,
            userId: userId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<int?> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              ChatsCompanion.insert(
            id: id,
            title: title,
            userId: userId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ChatsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userId = false,
              messagesRefs = false,
              categoryChatRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesRefs) db.messages,
                if (categoryChatRefs) db.categoryChat
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$ChatsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ChatsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ChatsTableReferences._messagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableReferences(db, table, p0).messagesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.chatId == item.id),
                        typedResults: items),
                  if (categoryChatRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ChatsTableReferences._categoryChatRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatsTableReferences(db, table, p0)
                                .categoryChatRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.chatId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatsTable,
    Chat,
    $$ChatsTableFilterComposer,
    $$ChatsTableOrderingComposer,
    $$ChatsTableAnnotationComposer,
    $$ChatsTableCreateCompanionBuilder,
    $$ChatsTableUpdateCompanionBuilder,
    (Chat, $$ChatsTableReferences),
    Chat,
    PrefetchHooks Function(
        {bool userId, bool messagesRefs, bool categoryChatRefs})>;
typedef $$MessagesTableCreateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  required int chatId,
  required String messageText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required bool isBot,
});
typedef $$MessagesTableUpdateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  Value<int> chatId,
  Value<String> messageText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isBot,
});

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatsTable _chatIdTable(_$AppDatabase db) => db.chats
      .createAlias($_aliasNameGenerator(db.messages.chatId, db.chats.id));

  $$ChatsTableProcessedTableManager get chatId {
    final manager = $$ChatsTableTableManager($_db, $_db.chats)
        .filter((f) => f.id($_item.chatId));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FileMessageTable, List<FileMessageData>>
      _fileMessageRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.fileMessage,
          aliasName:
              $_aliasNameGenerator(db.messages.id, db.fileMessage.messageId));

  $$FileMessageTableProcessedTableManager get fileMessageRefs {
    final manager = $$FileMessageTableTableManager($_db, $_db.fileMessage)
        .filter((f) => f.messageId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_fileMessageRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBot => $composableBuilder(
      column: $table.isBot, builder: (column) => ColumnFilters(column));

  $$ChatsTableFilterComposer get chatId {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableFilterComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> fileMessageRefs(
      Expression<bool> Function($$FileMessageTableFilterComposer f) f) {
    final $$FileMessageTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fileMessage,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FileMessageTableFilterComposer(
              $db: $db,
              $table: $db.fileMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBot => $composableBuilder(
      column: $table.isBot, builder: (column) => ColumnOrderings(column));

  $$ChatsTableOrderingComposer get chatId {
    final $$ChatsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableOrderingComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isBot =>
      $composableBuilder(column: $table.isBot, builder: (column) => column);

  $$ChatsTableAnnotationComposer get chatId {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableAnnotationComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> fileMessageRefs<T extends Object>(
      Expression<T> Function($$FileMessageTableAnnotationComposer a) f) {
    final $$FileMessageTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fileMessage,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FileMessageTableAnnotationComposer(
              $db: $db,
              $table: $db.fileMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, $$MessagesTableReferences),
    Message,
    PrefetchHooks Function({bool chatId, bool fileMessageRefs})> {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<String> messageText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isBot = const Value.absent(),
          }) =>
              MessagesCompanion(
            id: id,
            chatId: chatId,
            messageText: messageText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isBot: isBot,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int chatId,
            required String messageText,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            required bool isBot,
          }) =>
              MessagesCompanion.insert(
            id: id,
            chatId: chatId,
            messageText: messageText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isBot: isBot,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MessagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({chatId = false, fileMessageRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (fileMessageRefs) db.fileMessage],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (chatId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chatId,
                    referencedTable: $$MessagesTableReferences._chatIdTable(db),
                    referencedColumn:
                        $$MessagesTableReferences._chatIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fileMessageRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MessagesTableReferences._fileMessageRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MessagesTableReferences(db, table, p0)
                                .fileMessageRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.messageId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, $$MessagesTableReferences),
    Message,
    PrefetchHooks Function({bool chatId, bool fileMessageRefs})>;
typedef $$CategoryChatTableCreateCompanionBuilder = CategoryChatCompanion
    Function({
  Value<int> id,
  required int categoryId,
  required int chatId,
});
typedef $$CategoryChatTableUpdateCompanionBuilder = CategoryChatCompanion
    Function({
  Value<int> id,
  Value<int> categoryId,
  Value<int> chatId,
});

final class $$CategoryChatTableReferences extends BaseReferences<_$AppDatabase,
    $CategoryChatTable, CategoryChatData> {
  $$CategoryChatTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
          $_aliasNameGenerator(db.categoryChat.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager get categoryId {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id($_item.categoryId));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChatsTable _chatIdTable(_$AppDatabase db) => db.chats
      .createAlias($_aliasNameGenerator(db.categoryChat.chatId, db.chats.id));

  $$ChatsTableProcessedTableManager get chatId {
    final manager = $$ChatsTableTableManager($_db, $_db.chats)
        .filter((f) => f.id($_item.chatId));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CategoryChatTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryChatTable> {
  $$CategoryChatTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatsTableFilterComposer get chatId {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableFilterComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryChatTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryChatTable> {
  $$CategoryChatTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatsTableOrderingComposer get chatId {
    final $$ChatsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableOrderingComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryChatTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryChatTable> {
  $$CategoryChatTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatsTableAnnotationComposer get chatId {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $db.chats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatsTableAnnotationComposer(
              $db: $db,
              $table: $db.chats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryChatTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryChatTable,
    CategoryChatData,
    $$CategoryChatTableFilterComposer,
    $$CategoryChatTableOrderingComposer,
    $$CategoryChatTableAnnotationComposer,
    $$CategoryChatTableCreateCompanionBuilder,
    $$CategoryChatTableUpdateCompanionBuilder,
    (CategoryChatData, $$CategoryChatTableReferences),
    CategoryChatData,
    PrefetchHooks Function({bool categoryId, bool chatId})> {
  $$CategoryChatTableTableManager(_$AppDatabase db, $CategoryChatTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryChatTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryChatTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryChatTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<int> chatId = const Value.absent(),
          }) =>
              CategoryChatCompanion(
            id: id,
            categoryId: categoryId,
            chatId: chatId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int categoryId,
            required int chatId,
          }) =>
              CategoryChatCompanion.insert(
            id: id,
            categoryId: categoryId,
            chatId: chatId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoryChatTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false, chatId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$CategoryChatTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$CategoryChatTableReferences._categoryIdTable(db).id,
                  ) as T;
                }
                if (chatId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.chatId,
                    referencedTable:
                        $$CategoryChatTableReferences._chatIdTable(db),
                    referencedColumn:
                        $$CategoryChatTableReferences._chatIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CategoryChatTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryChatTable,
    CategoryChatData,
    $$CategoryChatTableFilterComposer,
    $$CategoryChatTableOrderingComposer,
    $$CategoryChatTableAnnotationComposer,
    $$CategoryChatTableCreateCompanionBuilder,
    $$CategoryChatTableUpdateCompanionBuilder,
    (CategoryChatData, $$CategoryChatTableReferences),
    CategoryChatData,
    PrefetchHooks Function({bool categoryId, bool chatId})>;
typedef $$FileMessageTableCreateCompanionBuilder = FileMessageCompanion
    Function({
  Value<int> id,
  required int messageId,
  required String fileId,
});
typedef $$FileMessageTableUpdateCompanionBuilder = FileMessageCompanion
    Function({
  Value<int> id,
  Value<int> messageId,
  Value<String> fileId,
});

final class $$FileMessageTableReferences
    extends BaseReferences<_$AppDatabase, $FileMessageTable, FileMessageData> {
  $$FileMessageTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$AppDatabase db) =>
      db.messages.createAlias(
          $_aliasNameGenerator(db.fileMessage.messageId, db.messages.id));

  $$MessagesTableProcessedTableManager get messageId {
    final manager = $$MessagesTableTableManager($_db, $_db.messages)
        .filter((f) => f.id($_item.messageId));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FileMessageTableFilterComposer
    extends Composer<_$AppDatabase, $FileMessageTable> {
  $$FileMessageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileId => $composableBuilder(
      column: $table.fileId, builder: (column) => ColumnFilters(column));

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FileMessageTableOrderingComposer
    extends Composer<_$AppDatabase, $FileMessageTable> {
  $$FileMessageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileId => $composableBuilder(
      column: $table.fileId, builder: (column) => ColumnOrderings(column));

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableOrderingComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FileMessageTableAnnotationComposer
    extends Composer<_$AppDatabase, $FileMessageTable> {
  $$FileMessageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileId =>
      $composableBuilder(column: $table.fileId, builder: (column) => column);

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FileMessageTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FileMessageTable,
    FileMessageData,
    $$FileMessageTableFilterComposer,
    $$FileMessageTableOrderingComposer,
    $$FileMessageTableAnnotationComposer,
    $$FileMessageTableCreateCompanionBuilder,
    $$FileMessageTableUpdateCompanionBuilder,
    (FileMessageData, $$FileMessageTableReferences),
    FileMessageData,
    PrefetchHooks Function({bool messageId})> {
  $$FileMessageTableTableManager(_$AppDatabase db, $FileMessageTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FileMessageTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FileMessageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FileMessageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> messageId = const Value.absent(),
            Value<String> fileId = const Value.absent(),
          }) =>
              FileMessageCompanion(
            id: id,
            messageId: messageId,
            fileId: fileId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int messageId,
            required String fileId,
          }) =>
              FileMessageCompanion.insert(
            id: id,
            messageId: messageId,
            fileId: fileId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FileMessageTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (messageId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.messageId,
                    referencedTable:
                        $$FileMessageTableReferences._messageIdTable(db),
                    referencedColumn:
                        $$FileMessageTableReferences._messageIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FileMessageTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FileMessageTable,
    FileMessageData,
    $$FileMessageTableFilterComposer,
    $$FileMessageTableOrderingComposer,
    $$FileMessageTableAnnotationComposer,
    $$FileMessageTableCreateCompanionBuilder,
    $$FileMessageTableUpdateCompanionBuilder,
    (FileMessageData, $$FileMessageTableReferences),
    FileMessageData,
    PrefetchHooks Function({bool messageId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FilesdbTableTableManager get filesdb =>
      $$FilesdbTableTableManager(_db, _db.filesdb);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$CategoryChatTableTableManager get categoryChat =>
      $$CategoryChatTableTableManager(_db, _db.categoryChat);
  $$FileMessageTableTableManager get fileMessage =>
      $$FileMessageTableTableManager(_db, _db.fileMessage);
}
