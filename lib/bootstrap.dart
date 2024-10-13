import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)', name: '${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log(
      'onError(${bloc.runtimeType}, $error, $stackTrace)',
      name: '${bloc.runtimeType}',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('onClose(${bloc.runtimeType})', name: '${bloc.runtimeType}');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate(${bloc.runtimeType})', name: '${bloc.runtimeType}');
    super.onCreate(bloc);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  runApp(await builder());
}
