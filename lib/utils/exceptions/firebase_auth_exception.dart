class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException({required this.code});

  String get message {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      case 'user-token-revoked':
        return 'The user\'s token has revoked. Please sign in again.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'email-already-exists':
        return 'The email address is already exists Please use a different email.';
      case 'operation-not-allowed':
        return 'Sign-in with this method is not enabled.';
      case 'weak-password':
        return 'The password provided is too weak. Choose a stronger password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential provided is malformed or has expired.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please check and try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please check and try again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'invalid-phone-number':
        return 'The phone number format is incorrect.';
      case 'too-many-requests':
        return 'Too many requests have been made from this device. Try again later.';
      case 'provider-already-linked':
        return 'This provider is already linked to this account.';
      case 'requires-recent-login':
        return 'Please log in again to perform this operation.';
      case 'user-mismatch':
        return 'The supplied credentials do not match the previously signed-in user.';
      case 'invalid-action-code':
        return 'The action code is invalid. This could be due to it being malformed, expired, or already used.';
      case 'missing-email':
        return 'Please enter your email address.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'missing-continue-uri':
        return 'A continue URL must be provided.';
      case 'invalid-continue-uri':
        return 'The continue URL provided in the request is invalid.';
      case 'missing-phone-number':
        return 'A phone number must be provided for phone authentication.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new code.';
      case 'invalid-message-payload':
        return 'The email action message is invalid. Please try again.';
      case 'unverified-email':
        return 'This action requires a verified email address.';
      case 'network-request-failed':
        return 'A network error occurred. Check your connection and try again.';
      case 'web-context-cancelled':
        return 'The operation was canceled due to a web context closure.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
