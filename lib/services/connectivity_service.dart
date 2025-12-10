import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  final _connectivityController = StreamController<List<ConnectivityResult>>.broadcast();

  Stream<List<ConnectivityResult>> get connectivityStream => _connectivityController.stream;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _connectivityController.add(results);
    });
  }

  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();

    return !results.contains(ConnectivityResult.none);
  }

  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  void dispose() {
    _connectivityController.close();
  }
}