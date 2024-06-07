@JS()
library js_interop_service;

import 'package:js/js.dart';

@JS()
external _showAlert(String message);

class JsInteropService {
  showAlert(String message) {
    _showAlert(message);
  }
}
