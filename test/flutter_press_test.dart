Future<void> main() async {
  print('Hello World');
  await Future.delayed(Duration(seconds: 1))
      .then((value) => print('Hello World'));
}
