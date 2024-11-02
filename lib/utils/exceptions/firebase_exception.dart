class TFirebaseException implements Exception {
  final String code;

  TFirebaseException({required this.code});

  String get message {
    switch (code) {
      // Authentication Errors
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled by the administrator.';
      case 'user-not-found':
        return 'No user found with the given credentials.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'This email is already associated with another account.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger one.';

      // Storage Errors
      case 'object-not-found':
        return 'The requested file does not exist.';
      case 'unauthorized':
        return 'You are not authorized to access this resource.';
      case 'retry-limit-exceeded':
        return 'Too many retry attempts. Please try again later.';
      case 'invalid-checksum':
        return 'The file is corrupted. Upload failed.';
      case 'canceled':
        return 'The upload has been canceled by the user.';

      // Database Errors
      case 'permission-denied':
        return 'You do not have permission to access this data.';
      case 'data-stale':
        return 'Data is stale and may not be accurate. Please refresh.';
      case 'operation-failed':
        return 'The operation failed due to an unknown error.';

      // Firestore Errors
      case 'already-exists':
        return 'The document already exists in the database.';
      case 'not-found':
        return 'The requested document does not exist.';
      case 'failed-precondition':
        return 'Operation failed due to a failed precondition.';

      // Cloud Functions Errors
      case 'function-deadline-exceeded':
        return 'The function took too long to execute.';
      case 'function-cancelled':
        return 'The operation was canceled by the server.';
      case 'invalid-argument':
        return 'The function received an invalid argument.';

      // Network Errors
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'deadline-exceeded':
        return 'The request took too long to complete. Please try again.';

      // Miscellaneous Errors
      case 'unknown':
        return 'An unknown error occurred. Please try again later.';
      case 'internal':
        return 'An internal error occurred. Please try again later.';
      case 'unauthenticated':
        return 'You are not authenticated. Please log in and try again.';

      // Default case for unhandled errors
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
