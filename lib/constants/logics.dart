String truncateString(String input) {
  if (input.length <= 17) {
    return input;
  }

  return "${input.substring(0, 17)}...";
}
