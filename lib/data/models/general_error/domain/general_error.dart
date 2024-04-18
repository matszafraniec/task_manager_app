class GeneralError {
  final String message;

  GeneralError(this.message);

  factory GeneralError.dataNotFound() => GeneralError('DATA_NOT_FOUND');
  factory GeneralError.unexpected() => GeneralError('UNEXPECTED');
}
