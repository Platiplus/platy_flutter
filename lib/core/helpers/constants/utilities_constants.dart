final RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    caseSensitive: false,
    multiLine: false
);

final RegExp numberRegex = new RegExp(
  r"^(-?\d+\.\d+)$|^(-?\d+)$",
  caseSensitive: false,
  multiLine: false
);

final requestHeaders = {
  'content-type': 'application/json'
};