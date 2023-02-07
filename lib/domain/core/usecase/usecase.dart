import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class AddEventParameters {
  AddEventParameters({
    required this.ownerId,
    required this.ownerEmail,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.dateTime,
    required this.file,
  });

  final String ownerId;
  final String ownerEmail;
  final String title;
  final String description;
  final String categoryId;
  final DateTime dateTime;
  final File? file;
}
