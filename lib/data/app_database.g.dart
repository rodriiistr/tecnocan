// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoPaternoMeta = const VerificationMeta(
    'apellidoPaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoPaterno = GeneratedColumn<String>(
    'apellido_paterno',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoMaternoMeta = const VerificationMeta(
    'apellidoMaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoMaterno = GeneratedColumn<String>(
    'apellido_materno',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    apellidoPaterno,
    apellidoMaterno,
    location,
    email,
    password,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('apellido_paterno')) {
      context.handle(
        _apellidoPaternoMeta,
        apellidoPaterno.isAcceptableOrUnknown(
          data['apellido_paterno']!,
          _apellidoPaternoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_apellidoPaternoMeta);
    }
    if (data.containsKey('apellido_materno')) {
      context.handle(
        _apellidoMaternoMeta,
        apellidoMaterno.isAcceptableOrUnknown(
          data['apellido_materno']!,
          _apellidoMaternoMeta,
        ),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      apellidoPaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_paterno'],
      )!,
      apellidoMaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_materno'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String nombre;
  final String apellidoPaterno;
  final String? apellidoMaterno;
  final String? location;
  final String email;
  final String password;
  final int createdAt;
  const User({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    this.apellidoMaterno,
    this.location,
    required this.email,
    required this.password,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['apellido_paterno'] = Variable<String>(apellidoPaterno);
    if (!nullToAbsent || apellidoMaterno != null) {
      map['apellido_materno'] = Variable<String>(apellidoMaterno);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      nombre: Value(nombre),
      apellidoPaterno: Value(apellidoPaterno),
      apellidoMaterno: apellidoMaterno == null && nullToAbsent
          ? const Value.absent()
          : Value(apellidoMaterno),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      email: Value(email),
      password: Value(password),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      apellidoPaterno: serializer.fromJson<String>(json['apellidoPaterno']),
      apellidoMaterno: serializer.fromJson<String?>(json['apellidoMaterno']),
      location: serializer.fromJson<String?>(json['location']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'apellidoPaterno': serializer.toJson<String>(apellidoPaterno),
      'apellidoMaterno': serializer.toJson<String?>(apellidoMaterno),
      'location': serializer.toJson<String?>(location),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? nombre,
    String? apellidoPaterno,
    Value<String?> apellidoMaterno = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? email,
    String? password,
    int? createdAt,
  }) => User(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno.present
        ? apellidoMaterno.value
        : this.apellidoMaterno,
    location: location.present ? location.value : this.location,
    email: email ?? this.email,
    password: password ?? this.password,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellidoPaterno: data.apellidoPaterno.present
          ? data.apellidoPaterno.value
          : this.apellidoPaterno,
      apellidoMaterno: data.apellidoMaterno.present
          ? data.apellidoMaterno.value
          : this.apellidoMaterno,
      location: data.location.present ? data.location.value : this.location,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('location: $location, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    apellidoPaterno,
    apellidoMaterno,
    location,
    email,
    password,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.apellidoPaterno == this.apellidoPaterno &&
          other.apellidoMaterno == this.apellidoMaterno &&
          other.location == this.location &&
          other.email == this.email &&
          other.password == this.password &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> apellidoPaterno;
  final Value<String?> apellidoMaterno;
  final Value<String?> location;
  final Value<String> email;
  final Value<String> password;
  final Value<int> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellidoPaterno = const Value.absent(),
    this.apellidoMaterno = const Value.absent(),
    this.location = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String apellidoPaterno,
    this.apellidoMaterno = const Value.absent(),
    this.location = const Value.absent(),
    required String email,
    required String password,
    this.createdAt = const Value.absent(),
  }) : nombre = Value(nombre),
       apellidoPaterno = Value(apellidoPaterno),
       email = Value(email),
       password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? apellidoPaterno,
    Expression<String>? apellidoMaterno,
    Expression<String>? location,
    Expression<String>? email,
    Expression<String>? password,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (apellidoPaterno != null) 'apellido_paterno': apellidoPaterno,
      if (apellidoMaterno != null) 'apellido_materno': apellidoMaterno,
      if (location != null) 'location': location,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? apellidoPaterno,
    Value<String?>? apellidoMaterno,
    Value<String?>? location,
    Value<String>? email,
    Value<String>? password,
    Value<int>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
      apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
      location: location ?? this.location,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellidoPaterno.present) {
      map['apellido_paterno'] = Variable<String>(apellidoPaterno.value);
    }
    if (apellidoMaterno.present) {
      map['apellido_materno'] = Variable<String>(apellidoMaterno.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('location: $location, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<int> birthDate = GeneratedColumn<int>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    breed,
    birthDate,
    sex,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_date'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final int id;
  final int userId;
  final String name;
  final String breed;
  final int birthDate;
  final String sex;
  final String? photoPath;
  const Pet({
    required this.id,
    required this.userId,
    required this.name,
    required this.breed,
    required this.birthDate,
    required this.sex,
    this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['breed'] = Variable<String>(breed);
    map['birth_date'] = Variable<int>(birthDate);
    map['sex'] = Variable<String>(sex);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      breed: Value(breed),
      birthDate: Value(birthDate),
      sex: Value(sex),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory Pet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      breed: serializer.fromJson<String>(json['breed']),
      birthDate: serializer.fromJson<int>(json['birthDate']),
      sex: serializer.fromJson<String>(json['sex']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'breed': serializer.toJson<String>(breed),
      'birthDate': serializer.toJson<int>(birthDate),
      'sex': serializer.toJson<String>(sex),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  Pet copyWith({
    int? id,
    int? userId,
    String? name,
    String? breed,
    int? birthDate,
    String? sex,
    Value<String?> photoPath = const Value.absent(),
  }) => Pet(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    breed: breed ?? this.breed,
    birthDate: birthDate ?? this.birthDate,
    sex: sex ?? this.sex,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
  );
  Pet copyWithCompanion(PetsCompanion data) {
    return Pet(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      breed: data.breed.present ? data.breed.value : this.breed,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      sex: data.sex.present ? data.sex.value : this.sex,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('breed: $breed, ')
          ..write('birthDate: $birthDate, ')
          ..write('sex: $sex, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, breed, birthDate, sex, photoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.breed == this.breed &&
          other.birthDate == this.birthDate &&
          other.sex == this.sex &&
          other.photoPath == this.photoPath);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<String> breed;
  final Value<int> birthDate;
  final Value<String> sex;
  final Value<String?> photoPath;
  const PetsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.breed = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.sex = const Value.absent(),
    this.photoPath = const Value.absent(),
  });
  PetsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    required String breed,
    required int birthDate,
    required String sex,
    this.photoPath = const Value.absent(),
  }) : userId = Value(userId),
       name = Value(name),
       breed = Value(breed),
       birthDate = Value(birthDate),
       sex = Value(sex);
  static Insertable<Pet> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? breed,
    Expression<int>? birthDate,
    Expression<String>? sex,
    Expression<String>? photoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (breed != null) 'breed': breed,
      if (birthDate != null) 'birth_date': birthDate,
      if (sex != null) 'sex': sex,
      if (photoPath != null) 'photo_path': photoPath,
    });
  }

  PetsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? name,
    Value<String>? breed,
    Value<int>? birthDate,
    Value<String>? sex,
    Value<String?>? photoPath,
  }) {
    return PetsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<int>(birthDate.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('breed: $breed, ')
          ..write('birthDate: $birthDate, ')
          ..write('sex: $sex, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }
}

class $FeedingSchedulesTable extends FeedingSchedules
    with TableInfo<$FeedingSchedulesTable, FeedingSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (id)',
    ),
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, petId, frequency, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeding_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedingSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedingSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedingSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FeedingSchedulesTable createAlias(String alias) {
    return $FeedingSchedulesTable(attachedDatabase, alias);
  }
}

class FeedingSchedule extends DataClass implements Insertable<FeedingSchedule> {
  final int id;
  final int petId;
  final int frequency;
  final int createdAt;
  const FeedingSchedule({
    required this.id,
    required this.petId,
    required this.frequency,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    map['frequency'] = Variable<int>(frequency);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  FeedingSchedulesCompanion toCompanion(bool nullToAbsent) {
    return FeedingSchedulesCompanion(
      id: Value(id),
      petId: Value(petId),
      frequency: Value(frequency),
      createdAt: Value(createdAt),
    );
  }

  factory FeedingSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedingSchedule(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      frequency: serializer.fromJson<int>(json['frequency']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'frequency': serializer.toJson<int>(frequency),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  FeedingSchedule copyWith({
    int? id,
    int? petId,
    int? frequency,
    int? createdAt,
  }) => FeedingSchedule(
    id: id ?? this.id,
    petId: petId ?? this.petId,
    frequency: frequency ?? this.frequency,
    createdAt: createdAt ?? this.createdAt,
  );
  FeedingSchedule copyWithCompanion(FeedingSchedulesCompanion data) {
    return FeedingSchedule(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedingSchedule(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('frequency: $frequency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, frequency, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedingSchedule &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.frequency == this.frequency &&
          other.createdAt == this.createdAt);
}

class FeedingSchedulesCompanion extends UpdateCompanion<FeedingSchedule> {
  final Value<int> id;
  final Value<int> petId;
  final Value<int> frequency;
  final Value<int> createdAt;
  const FeedingSchedulesCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.frequency = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FeedingSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int petId,
    required int frequency,
    this.createdAt = const Value.absent(),
  }) : petId = Value(petId),
       frequency = Value(frequency);
  static Insertable<FeedingSchedule> custom({
    Expression<int>? id,
    Expression<int>? petId,
    Expression<int>? frequency,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (frequency != null) 'frequency': frequency,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FeedingSchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? petId,
    Value<int>? frequency,
    Value<int>? createdAt,
  }) {
    return FeedingSchedulesCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('frequency: $frequency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeedingTimesTable extends FeedingTimes
    with TableInfo<$FeedingTimesTable, FeedingTime> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingTimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scheduleIdMeta = const VerificationMeta(
    'scheduleId',
  );
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
    'schedule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feeding_schedules (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, scheduleId, name, time, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeding_times';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedingTime> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
        _scheduleIdMeta,
        scheduleId.isAcceptableOrUnknown(data['schedule_id']!, _scheduleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_scheduleIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedingTime map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedingTime(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scheduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $FeedingTimesTable createAlias(String alias) {
    return $FeedingTimesTable(attachedDatabase, alias);
  }
}

class FeedingTime extends DataClass implements Insertable<FeedingTime> {
  final int id;
  final int scheduleId;
  final String name;
  final String time;
  final double amount;
  const FeedingTime({
    required this.id,
    required this.scheduleId,
    required this.name,
    required this.time,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schedule_id'] = Variable<int>(scheduleId);
    map['name'] = Variable<String>(name);
    map['time'] = Variable<String>(time);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  FeedingTimesCompanion toCompanion(bool nullToAbsent) {
    return FeedingTimesCompanion(
      id: Value(id),
      scheduleId: Value(scheduleId),
      name: Value(name),
      time: Value(time),
      amount: Value(amount),
    );
  }

  factory FeedingTime.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedingTime(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<int>(json['scheduleId']),
      name: serializer.fromJson<String>(json['name']),
      time: serializer.fromJson<String>(json['time']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<int>(scheduleId),
      'name': serializer.toJson<String>(name),
      'time': serializer.toJson<String>(time),
      'amount': serializer.toJson<double>(amount),
    };
  }

  FeedingTime copyWith({
    int? id,
    int? scheduleId,
    String? name,
    String? time,
    double? amount,
  }) => FeedingTime(
    id: id ?? this.id,
    scheduleId: scheduleId ?? this.scheduleId,
    name: name ?? this.name,
    time: time ?? this.time,
    amount: amount ?? this.amount,
  );
  FeedingTime copyWithCompanion(FeedingTimesCompanion data) {
    return FeedingTime(
      id: data.id.present ? data.id.value : this.id,
      scheduleId: data.scheduleId.present
          ? data.scheduleId.value
          : this.scheduleId,
      name: data.name.present ? data.name.value : this.name,
      time: data.time.present ? data.time.value : this.time,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedingTime(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('name: $name, ')
          ..write('time: $time, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scheduleId, name, time, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedingTime &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.name == this.name &&
          other.time == this.time &&
          other.amount == this.amount);
}

class FeedingTimesCompanion extends UpdateCompanion<FeedingTime> {
  final Value<int> id;
  final Value<int> scheduleId;
  final Value<String> name;
  final Value<String> time;
  final Value<double> amount;
  const FeedingTimesCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.name = const Value.absent(),
    this.time = const Value.absent(),
    this.amount = const Value.absent(),
  });
  FeedingTimesCompanion.insert({
    this.id = const Value.absent(),
    required int scheduleId,
    required String name,
    required String time,
    required double amount,
  }) : scheduleId = Value(scheduleId),
       name = Value(name),
       time = Value(time),
       amount = Value(amount);
  static Insertable<FeedingTime> custom({
    Expression<int>? id,
    Expression<int>? scheduleId,
    Expression<String>? name,
    Expression<String>? time,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (name != null) 'name': name,
      if (time != null) 'time': time,
      if (amount != null) 'amount': amount,
    });
  }

  FeedingTimesCompanion copyWith({
    Value<int>? id,
    Value<int>? scheduleId,
    Value<String>? name,
    Value<String>? time,
    Value<double>? amount,
  }) {
    return FeedingTimesCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      name: name ?? this.name,
      time: time ?? this.time,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingTimesCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('name: $name, ')
          ..write('time: $time, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (id)',
    ),
  );
  static const VerificationMeta _macAddressMeta = const VerificationMeta(
    'macAddress',
  );
  @override
  late final GeneratedColumn<String> macAddress = GeneratedColumn<String>(
    'mac_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectedAtMeta = const VerificationMeta(
    'connectedAt',
  );
  @override
  late final GeneratedColumn<int> connectedAt = GeneratedColumn<int>(
    'connected_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    petId,
    macAddress,
    nickname,
    connectedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('mac_address')) {
      context.handle(
        _macAddressMeta,
        macAddress.isAcceptableOrUnknown(data['mac_address']!, _macAddressMeta),
      );
    } else if (isInserting) {
      context.missing(_macAddressMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('connected_at')) {
      context.handle(
        _connectedAtMeta,
        connectedAt.isAcceptableOrUnknown(
          data['connected_at']!,
          _connectedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      macAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mac_address'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      connectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}connected_at'],
      )!,
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final int id;
  final int petId;
  final String macAddress;
  final String? nickname;
  final int connectedAt;
  const Device({
    required this.id,
    required this.petId,
    required this.macAddress,
    this.nickname,
    required this.connectedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    map['mac_address'] = Variable<String>(macAddress);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['connected_at'] = Variable<int>(connectedAt);
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      petId: Value(petId),
      macAddress: Value(macAddress),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      connectedAt: Value(connectedAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      macAddress: serializer.fromJson<String>(json['macAddress']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      connectedAt: serializer.fromJson<int>(json['connectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'macAddress': serializer.toJson<String>(macAddress),
      'nickname': serializer.toJson<String?>(nickname),
      'connectedAt': serializer.toJson<int>(connectedAt),
    };
  }

  Device copyWith({
    int? id,
    int? petId,
    String? macAddress,
    Value<String?> nickname = const Value.absent(),
    int? connectedAt,
  }) => Device(
    id: id ?? this.id,
    petId: petId ?? this.petId,
    macAddress: macAddress ?? this.macAddress,
    nickname: nickname.present ? nickname.value : this.nickname,
    connectedAt: connectedAt ?? this.connectedAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      macAddress: data.macAddress.present
          ? data.macAddress.value
          : this.macAddress,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      connectedAt: data.connectedAt.present
          ? data.connectedAt.value
          : this.connectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('macAddress: $macAddress, ')
          ..write('nickname: $nickname, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, macAddress, nickname, connectedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.macAddress == this.macAddress &&
          other.nickname == this.nickname &&
          other.connectedAt == this.connectedAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<int> id;
  final Value<int> petId;
  final Value<String> macAddress;
  final Value<String?> nickname;
  final Value<int> connectedAt;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.macAddress = const Value.absent(),
    this.nickname = const Value.absent(),
    this.connectedAt = const Value.absent(),
  });
  DevicesCompanion.insert({
    this.id = const Value.absent(),
    required int petId,
    required String macAddress,
    this.nickname = const Value.absent(),
    this.connectedAt = const Value.absent(),
  }) : petId = Value(petId),
       macAddress = Value(macAddress);
  static Insertable<Device> custom({
    Expression<int>? id,
    Expression<int>? petId,
    Expression<String>? macAddress,
    Expression<String>? nickname,
    Expression<int>? connectedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (macAddress != null) 'mac_address': macAddress,
      if (nickname != null) 'nickname': nickname,
      if (connectedAt != null) 'connected_at': connectedAt,
    });
  }

  DevicesCompanion copyWith({
    Value<int>? id,
    Value<int>? petId,
    Value<String>? macAddress,
    Value<String?>? nickname,
    Value<int>? connectedAt,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      macAddress: macAddress ?? this.macAddress,
      nickname: nickname ?? this.nickname,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (macAddress.present) {
      map['mac_address'] = Variable<String>(macAddress.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (connectedAt.present) {
      map['connected_at'] = Variable<int>(connectedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('macAddress: $macAddress, ')
          ..write('nickname: $nickname, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $FeedingSchedulesTable feedingSchedules = $FeedingSchedulesTable(
    this,
  );
  late final $FeedingTimesTable feedingTimes = $FeedingTimesTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    pets,
    feedingSchedules,
    feedingTimes,
    devices,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String nombre,
      required String apellidoPaterno,
      Value<String?> apellidoMaterno,
      Value<String?> location,
      required String email,
      required String password,
      Value<int> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> apellidoPaterno,
      Value<String?> apellidoMaterno,
      Value<String?> location,
      Value<String> email,
      Value<String> password,
      Value<int> createdAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PetsTable, List<Pet>> _petsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pets,
    aliasName: $_aliasNameGenerator(db.users.id, db.pets.userId),
  );

  $$PetsTableProcessedTableManager get petsRefs {
    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_petsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> petsRefs(
    Expression<bool> Function($$PetsTableFilterComposer f) f,
  ) {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> petsRefs<T extends Object>(
    Expression<T> Function($$PetsTableAnnotationComposer a) f,
  ) {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({bool petsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> apellidoPaterno = const Value.absent(),
                Value<String?> apellidoMaterno = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                nombre: nombre,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                location: location,
                email: email,
                password: password,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String apellidoPaterno,
                Value<String?> apellidoMaterno = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required String email,
                required String password,
                Value<int> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                nombre: nombre,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                location: location,
                email: email,
                password: password,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({petsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (petsRefs) db.pets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (petsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Pet>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._petsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).petsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({bool petsRefs})
    >;
typedef $$PetsTableCreateCompanionBuilder =
    PetsCompanion Function({
      Value<int> id,
      required int userId,
      required String name,
      required String breed,
      required int birthDate,
      required String sex,
      Value<String?> photoPath,
    });
typedef $$PetsTableUpdateCompanionBuilder =
    PetsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> name,
      Value<String> breed,
      Value<int> birthDate,
      Value<String> sex,
      Value<String?> photoPath,
    });

final class $$PetsTableReferences
    extends BaseReferences<_$AppDatabase, $PetsTable, Pet> {
  $$PetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.pets.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FeedingSchedulesTable, List<FeedingSchedule>>
  _feedingSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedingSchedules,
    aliasName: $_aliasNameGenerator(db.pets.id, db.feedingSchedules.petId),
  );

  $$FeedingSchedulesTableProcessedTableManager get feedingSchedulesRefs {
    final manager = $$FeedingSchedulesTableTableManager(
      $_db,
      $_db.feedingSchedules,
    ).filter((f) => f.petId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _feedingSchedulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DevicesTable, List<Device>> _devicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.devices,
    aliasName: $_aliasNameGenerator(db.pets.id, db.devices.petId),
  );

  $$DevicesTableProcessedTableManager get devicesRefs {
    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.petId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_devicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PetsTableFilterComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> feedingSchedulesRefs(
    Expression<bool> Function($$FeedingSchedulesTableFilterComposer f) f,
  ) {
    final $$FeedingSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingSchedules,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.feedingSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> devicesRefs(
    Expression<bool> Function($$DevicesTableFilterComposer f) f,
  ) {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PetsTableOrderingComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableAnnotationComposer({
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

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<int> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> feedingSchedulesRefs<T extends Object>(
    Expression<T> Function($$FeedingSchedulesTableAnnotationComposer a) f,
  ) {
    final $$FeedingSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingSchedules,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.feedingSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> devicesRefs<T extends Object>(
    Expression<T> Function($$DevicesTableAnnotationComposer a) f,
  ) {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetsTable,
          Pet,
          $$PetsTableFilterComposer,
          $$PetsTableOrderingComposer,
          $$PetsTableAnnotationComposer,
          $$PetsTableCreateCompanionBuilder,
          $$PetsTableUpdateCompanionBuilder,
          (Pet, $$PetsTableReferences),
          Pet,
          PrefetchHooks Function({
            bool userId,
            bool feedingSchedulesRefs,
            bool devicesRefs,
          })
        > {
  $$PetsTableTableManager(_$AppDatabase db, $PetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<int> birthDate = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => PetsCompanion(
                id: id,
                userId: userId,
                name: name,
                breed: breed,
                birthDate: birthDate,
                sex: sex,
                photoPath: photoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String name,
                required String breed,
                required int birthDate,
                required String sex,
                Value<String?> photoPath = const Value.absent(),
              }) => PetsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                breed: breed,
                birthDate: birthDate,
                sex: sex,
                photoPath: photoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PetsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                feedingSchedulesRefs = false,
                devicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (feedingSchedulesRefs) db.feedingSchedules,
                    if (devicesRefs) db.devices,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$PetsTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$PetsTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (feedingSchedulesRefs)
                        await $_getPrefetchedData<
                          Pet,
                          $PetsTable,
                          FeedingSchedule
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._feedingSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).feedingSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.petId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (devicesRefs)
                        await $_getPrefetchedData<Pet, $PetsTable, Device>(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._devicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PetsTableReferences(db, table, p0).devicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.petId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetsTable,
      Pet,
      $$PetsTableFilterComposer,
      $$PetsTableOrderingComposer,
      $$PetsTableAnnotationComposer,
      $$PetsTableCreateCompanionBuilder,
      $$PetsTableUpdateCompanionBuilder,
      (Pet, $$PetsTableReferences),
      Pet,
      PrefetchHooks Function({
        bool userId,
        bool feedingSchedulesRefs,
        bool devicesRefs,
      })
    >;
typedef $$FeedingSchedulesTableCreateCompanionBuilder =
    FeedingSchedulesCompanion Function({
      Value<int> id,
      required int petId,
      required int frequency,
      Value<int> createdAt,
    });
typedef $$FeedingSchedulesTableUpdateCompanionBuilder =
    FeedingSchedulesCompanion Function({
      Value<int> id,
      Value<int> petId,
      Value<int> frequency,
      Value<int> createdAt,
    });

final class $$FeedingSchedulesTableReferences
    extends
        BaseReferences<_$AppDatabase, $FeedingSchedulesTable, FeedingSchedule> {
  $$FeedingSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PetsTable _petIdTable(_$AppDatabase db) => db.pets.createAlias(
    $_aliasNameGenerator(db.feedingSchedules.petId, db.pets.id),
  );

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FeedingTimesTable, List<FeedingTime>>
  _feedingTimesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedingTimes,
    aliasName: $_aliasNameGenerator(
      db.feedingSchedules.id,
      db.feedingTimes.scheduleId,
    ),
  );

  $$FeedingTimesTableProcessedTableManager get feedingTimesRefs {
    final manager = $$FeedingTimesTableTableManager(
      $_db,
      $_db.feedingTimes,
    ).filter((f) => f.scheduleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedingTimesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeedingSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> feedingTimesRefs(
    Expression<bool> Function($$FeedingTimesTableFilterComposer f) f,
  ) {
    final $$FeedingTimesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingTimes,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingTimesTableFilterComposer(
            $db: $db,
            $table: $db.feedingTimes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedingSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingSchedulesTable> {
  $$FeedingSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> feedingTimesRefs<T extends Object>(
    Expression<T> Function($$FeedingTimesTableAnnotationComposer a) f,
  ) {
    final $$FeedingTimesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingTimes,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingTimesTableAnnotationComposer(
            $db: $db,
            $table: $db.feedingTimes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedingSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedingSchedulesTable,
          FeedingSchedule,
          $$FeedingSchedulesTableFilterComposer,
          $$FeedingSchedulesTableOrderingComposer,
          $$FeedingSchedulesTableAnnotationComposer,
          $$FeedingSchedulesTableCreateCompanionBuilder,
          $$FeedingSchedulesTableUpdateCompanionBuilder,
          (FeedingSchedule, $$FeedingSchedulesTableReferences),
          FeedingSchedule,
          PrefetchHooks Function({bool petId, bool feedingTimesRefs})
        > {
  $$FeedingSchedulesTableTableManager(
    _$AppDatabase db,
    $FeedingSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<int> frequency = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => FeedingSchedulesCompanion(
                id: id,
                petId: petId,
                frequency: frequency,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int petId,
                required int frequency,
                Value<int> createdAt = const Value.absent(),
              }) => FeedingSchedulesCompanion.insert(
                id: id,
                petId: petId,
                frequency: frequency,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeedingSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false, feedingTimesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (feedingTimesRefs) db.feedingTimes],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.petId,
                                referencedTable:
                                    $$FeedingSchedulesTableReferences
                                        ._petIdTable(db),
                                referencedColumn:
                                    $$FeedingSchedulesTableReferences
                                        ._petIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedingTimesRefs)
                    await $_getPrefetchedData<
                      FeedingSchedule,
                      $FeedingSchedulesTable,
                      FeedingTime
                    >(
                      currentTable: table,
                      referencedTable: $$FeedingSchedulesTableReferences
                          ._feedingTimesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FeedingSchedulesTableReferences(
                            db,
                            table,
                            p0,
                          ).feedingTimesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.scheduleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FeedingSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedingSchedulesTable,
      FeedingSchedule,
      $$FeedingSchedulesTableFilterComposer,
      $$FeedingSchedulesTableOrderingComposer,
      $$FeedingSchedulesTableAnnotationComposer,
      $$FeedingSchedulesTableCreateCompanionBuilder,
      $$FeedingSchedulesTableUpdateCompanionBuilder,
      (FeedingSchedule, $$FeedingSchedulesTableReferences),
      FeedingSchedule,
      PrefetchHooks Function({bool petId, bool feedingTimesRefs})
    >;
typedef $$FeedingTimesTableCreateCompanionBuilder =
    FeedingTimesCompanion Function({
      Value<int> id,
      required int scheduleId,
      required String name,
      required String time,
      required double amount,
    });
typedef $$FeedingTimesTableUpdateCompanionBuilder =
    FeedingTimesCompanion Function({
      Value<int> id,
      Value<int> scheduleId,
      Value<String> name,
      Value<String> time,
      Value<double> amount,
    });

final class $$FeedingTimesTableReferences
    extends BaseReferences<_$AppDatabase, $FeedingTimesTable, FeedingTime> {
  $$FeedingTimesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeedingSchedulesTable _scheduleIdTable(_$AppDatabase db) =>
      db.feedingSchedules.createAlias(
        $_aliasNameGenerator(
          db.feedingTimes.scheduleId,
          db.feedingSchedules.id,
        ),
      );

  $$FeedingSchedulesTableProcessedTableManager get scheduleId {
    final $_column = $_itemColumn<int>('schedule_id')!;

    final manager = $$FeedingSchedulesTableTableManager(
      $_db,
      $_db.feedingSchedules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedingTimesTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingTimesTable> {
  $$FeedingTimesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$FeedingSchedulesTableFilterComposer get scheduleId {
    final $$FeedingSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.feedingSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.feedingSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingTimesTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingTimesTable> {
  $$FeedingTimesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeedingSchedulesTableOrderingComposer get scheduleId {
    final $$FeedingSchedulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.feedingSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingSchedulesTableOrderingComposer(
            $db: $db,
            $table: $db.feedingSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingTimesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingTimesTable> {
  $$FeedingTimesTableAnnotationComposer({
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

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$FeedingSchedulesTableAnnotationComposer get scheduleId {
    final $$FeedingSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.feedingSchedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.feedingSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingTimesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedingTimesTable,
          FeedingTime,
          $$FeedingTimesTableFilterComposer,
          $$FeedingTimesTableOrderingComposer,
          $$FeedingTimesTableAnnotationComposer,
          $$FeedingTimesTableCreateCompanionBuilder,
          $$FeedingTimesTableUpdateCompanionBuilder,
          (FeedingTime, $$FeedingTimesTableReferences),
          FeedingTime,
          PrefetchHooks Function({bool scheduleId})
        > {
  $$FeedingTimesTableTableManager(_$AppDatabase db, $FeedingTimesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingTimesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingTimesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingTimesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> scheduleId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => FeedingTimesCompanion(
                id: id,
                scheduleId: scheduleId,
                name: name,
                time: time,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int scheduleId,
                required String name,
                required String time,
                required double amount,
              }) => FeedingTimesCompanion.insert(
                id: id,
                scheduleId: scheduleId,
                name: name,
                time: time,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeedingTimesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scheduleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (scheduleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scheduleId,
                                referencedTable: $$FeedingTimesTableReferences
                                    ._scheduleIdTable(db),
                                referencedColumn: $$FeedingTimesTableReferences
                                    ._scheduleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FeedingTimesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedingTimesTable,
      FeedingTime,
      $$FeedingTimesTableFilterComposer,
      $$FeedingTimesTableOrderingComposer,
      $$FeedingTimesTableAnnotationComposer,
      $$FeedingTimesTableCreateCompanionBuilder,
      $$FeedingTimesTableUpdateCompanionBuilder,
      (FeedingTime, $$FeedingTimesTableReferences),
      FeedingTime,
      PrefetchHooks Function({bool scheduleId})
    >;
typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      Value<int> id,
      required int petId,
      required String macAddress,
      Value<String?> nickname,
      Value<int> connectedAt,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<int> id,
      Value<int> petId,
      Value<String> macAddress,
      Value<String?> nickname,
      Value<int> connectedAt,
    });

final class $$DevicesTableReferences
    extends BaseReferences<_$AppDatabase, $DevicesTable, Device> {
  $$DevicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDatabase db) =>
      db.pets.createAlias($_aliasNameGenerator(db.devices.petId, db.pets.id));

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get macAddress => $composableBuilder(
    column: $table.macAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get macAddress => $composableBuilder(
    column: $table.macAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get macAddress => $composableBuilder(
    column: $table.macAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<int> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => column,
  );

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, $$DevicesTableReferences),
          Device,
          PrefetchHooks Function({bool petId})
        > {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<String> macAddress = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<int> connectedAt = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                petId: petId,
                macAddress: macAddress,
                nickname: nickname,
                connectedAt: connectedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int petId,
                required String macAddress,
                Value<String?> nickname = const Value.absent(),
                Value<int> connectedAt = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                petId: petId,
                macAddress: macAddress,
                nickname: nickname,
                connectedAt: connectedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DevicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.petId,
                                referencedTable: $$DevicesTableReferences
                                    ._petIdTable(db),
                                referencedColumn: $$DevicesTableReferences
                                    ._petIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, $$DevicesTableReferences),
      Device,
      PrefetchHooks Function({bool petId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$FeedingSchedulesTableTableManager get feedingSchedules =>
      $$FeedingSchedulesTableTableManager(_db, _db.feedingSchedules);
  $$FeedingTimesTableTableManager get feedingTimes =>
      $$FeedingTimesTableTableManager(_db, _db.feedingTimes);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
}
