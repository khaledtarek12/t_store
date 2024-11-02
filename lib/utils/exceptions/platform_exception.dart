class TPlatformException implements Exception {
  final String code;

  TPlatformException({required this.code});

  String get message {
    switch (code) {
      case 'network-error':
        return 'Network error: Unable to reach the server. Please check your connection.';
      case 'file-not-found':
        return 'File not found. Please verify the file path and try again.';
      case 'permission-denied':
        return 'Permission denied. Please grant the necessary permissions in settings.';
      case 'battery-optimization':
        return 'Battery optimization settings may prevent this operation. Please disable optimization.';
      case 'camera-access-denied':
        return 'Camera access is denied. Please allow camera access in settings.';
      case 'location-service-disabled':
        return 'Location services are disabled. Please enable them in settings.';
      case 'bluetooth-not-available':
        return 'Bluetooth is not available on this device.';
      case 'storage-full':
        return 'Device storage is full. Please free up space and try again.';
      case 'no-internet-connection':
        return 'No internet connection. Please connect to a network and try again.';
      case 'api-not-available':
        return 'This API is not available on your device.';
      case 'operation-not-supported':
        return 'This operation is not supported on your device.';
      case 'timeout':
        return 'The operation timed out. Please try again later.';
      case 'database-locked':
        return 'The database is currently in use. Please wait and try again.';
      case 'invalid-platform':
        return 'This feature is not supported on the current platform.';
      case 'invalid-intent':
        return 'The intent is invalid. Please check the data and try again.';
      case 'file-already-exists':
        return 'A file with this name already exists.';
      case 'data-corruption':
        return 'The data appears to be corrupted. Please try reloading or reinstalling.';
      case 'audio-output-error':
        return 'Error in audio output. Please check your device’s sound settings.';
      case 'api-limit-exceeded':
        return 'The API usage limit has been exceeded. Please try again later.';
      case 'unknown-error':
        return 'An unknown platform error occurred. Please contact support.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
