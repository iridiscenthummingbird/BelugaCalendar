import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'find_event_state.dart';

@injectable
class FindEventCubit extends Cubit<FindEventState> {
  FindEventCubit() : super(FindEventInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
}
