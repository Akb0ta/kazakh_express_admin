import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'just_event.dart';
part 'just_state.dart';

class JustBloc extends Bloc<JustEvent, JustState> {
  JustBloc() : super(JustInitial()) {
    on<JustEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
