const CAPTION_MAX_LENGTH = 3;
const PASSWORD_MAX_LENGTH = 3;

bool validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return true;
  } else
    return false;
}

bool validateMaxStringLength(String input, int maxLength) {
  if (input.length <= maxLength) {
    return true;
  } else
    return false;
}
