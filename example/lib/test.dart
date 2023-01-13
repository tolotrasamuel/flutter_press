Future<void> makeError() async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('Error');
}

Future<void> main() async {
  print('Hello World');
  final d = await makeError().then((value) {
    print('Hello World');
    return 123;
  }).catchError((e) {
    print('Error $e');
    throw e;
  });
  print("d: $d");
}
