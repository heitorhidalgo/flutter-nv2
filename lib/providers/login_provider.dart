import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/login_controller.dart';

final ChangeNotifierProvider<LoginController> loginProvider =
  ChangeNotifierProvider<LoginController>((ref) => LoginController());