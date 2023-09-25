// Helps turn null values from an API into a 0.
int deserializeIntFromPossibleNull(dynamic value) {
  if (value == null) {
    return 0;
  }
  return value as int;
}
