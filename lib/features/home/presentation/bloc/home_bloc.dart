import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/state/base_state.dart';

class HomeBloc extends Cubit<BaseState> {
  HomeBloc() : super(const InitialState());
}
