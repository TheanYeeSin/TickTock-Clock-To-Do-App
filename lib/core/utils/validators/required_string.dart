String? requiredString(final String value, final String errorText) {
  if (value.isEmpty && value.trim().isEmpty) {
    return errorText;
  }
  return null;
}
