import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ewallet_app/models/topup_form_model.dart';
import 'package:ewallet_app/services/transaction_service.dart';

part 'topup_event.dart';
part 'topup_state.dart';

class TopupBloc extends Bloc<TopupEvent, TopupState> {
  TopupBloc() : super(TopupInitial()) {
    on<TopupEvent>((event, emit) async {
      if (event is TopupPost) {
        try {
          emit(TopupLoading());

          final redirectUrl = await TransactionService().topUp(event.data);

          emit(TopupSuccess(redirectUrl));
        } catch (e) {
          emit(TopupFailed(e.toString()));
        }
      }
    });
  }
}
