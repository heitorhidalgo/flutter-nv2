import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_state.dart';
import '../notifiers/login_notifier.dart';

final NotifierProvider<LoginNotifier, LoginState> loginProvider =
    NotifierProvider<LoginNotifier, LoginState>(LoginNotifier.new);