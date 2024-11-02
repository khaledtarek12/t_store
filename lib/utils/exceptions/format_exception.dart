class TFormatException implements Exception {
  final String message;

  const TFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  String get formattedMessage => message;

  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
            'The email format is invalid. Please enter a valid email.');
      case 'invalid-phone-number':
        return const TFormatException('The phone number format is invalid.');
      case 'invalid-date-format':
        return const TFormatException(
            'The date format is invalid. Expected format: YYYY-MM-DD.');
      case 'invalid-number-format':
        return const TFormatException('The input is not a valid number.');
      case 'unexpected-null-value':
        return const TFormatException('A required value was null.');
      case 'json-parsing-error':
        return const TFormatException(
            'Error parsing JSON data. Please check the input format.');
      case 'type-mismatch':
        return const TFormatException(
            'The data type is incorrect for the expected input.');
      case 'invalid-url':
        return const TFormatException('The URL format is invalid.');
      case 'unexpected-character':
        return const TFormatException(
            'The input contains unexpected characters.');
      case 'value-out-of-range':
        return const TFormatException(
            'The value is out of the acceptable range.');
      case 'invalid-hex-color':
        return const TFormatException(
            'The color code format is invalid. Expected format: #RRGGBB.');
      case 'empty-input':
        return const TFormatException('The input cannot be empty.');
      case 'password-too-short':
        return const TFormatException(
            'The password is too short. Minimum length required.');
      case 'invalid-currency-format':
        return const TFormatException('The currency format is invalid.');
      case 'invalid-file-path':
        return const TFormatException('The file path format is invalid.');
      case 'non-unique-identifier':
        return const TFormatException('The identifier must be unique.');
      case 'invalid-zip-code':
        return const TFormatException('The ZIP code format is invalid.');
      default:
        return const TFormatException();
    }
  }
}
