import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ewallet_app/models/transfer_model.dart';
import 'package:ewallet_app/services/transaction_service.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(TransferInitial()) {
    on<TransferEvent>((event, emit) async {
      if (event is TransferPost) {
        try {
          emit(TransferLoading());
          await TransactionService().transfer(event.data);

          emit(TransferSuccess());
        } catch (e) {
          emit(TransferFailed(e.toString()));
        }
      }
    });
  }
}
