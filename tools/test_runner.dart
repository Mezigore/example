// import 'dart:convert';
// import 'dart:io';
//
// import 'package:junitreport/junitreport.dart';
// import 'package:testreport/testreport.dart';
//
// Future<void> main() async {
//   final testRunnerResult = runTestRunner();
//   if (testRunnerResult.exitCode != 0) {
//     exit(testRunnerResult.exitCode);
//   }
//
//   try {
//     final currentPath = Directory.current.path;
//     final packageName = getPackageName();
//
//     final lines = LineSplitter.split(testRunnerResult.stdout.toString());
//     final report = createTestReport(lines);
//
//     final xml =
//         JUnitReport(base: currentPath, package: packageName).toXml(report);
//     File('$packageName-junit.xml').writeAsStringSync(xml.toString());
//
//     final surfReport = createSurfTestReport(packageName, currentPath, report);
//     await sendReport(surfReport.toJson());
//   } on Exception catch (e) {
//     stderr.writeln(e.toString());
//
//     exit(1);
//   }
// }
//
// ProcessResult runTestRunner() {
//   final result = Process.runSync(
//     'flutter',
//     ['test', '--no-pub', '--machine'],
//     stdoutEncoding: const Utf8Codec(),
//     stderrEncoding: const Utf8Codec(),
//   );
//
//   stdout.write(result.stdout);
//   stderr.write(result.stderr);
//
//   return result;
// }
//
// SurfTestReport createSurfTestReport(
//         String projectId, String testFolderPath, Report report) =>
//     SurfTestReport(
//       projectId,
//       report.suites
//           .map((suite) => SurfTestClass(
//                 suite.path.startsWith(testFolderPath)
//                     ? suite.path.substring(testFolderPath.length)
//                     : suite.path,
//                 suite.tests.map((test) => SurfTestData(
//                       test.name,
//                       test.duration / 1000,
//                     )),
//               ))
//           .toList(),
//     );
//
// Report createTestReport(Iterable<String> lines) {
//   final processor = Processor(timestamp: DateTime.now());
//   for (final line in lines) {
//     if (!line.startsWith('{')) {
//       continue;
//     }
//     processor.process(json.decode(line) as Map<String, Object>);
//   }
//
//   return processor.report;
// }
//
// Future<void> sendReport(Map<String, Object> data) async {
//   final client = HttpClient()..badCertificateCallback = ((_, __, ___) => true);
//   final request = await client.putUrl(Uri(
//     scheme: 'https',
//     host: 'stage.ps.surfstudio.ru',
//     path: '/data_consumer/tests',
//   ));
//   request.write(Uri.encodeFull(jsonEncode(data)));
//   final response = await request.close();
//   final contentAsString = await utf8.decodeStream(response);
//   stdout.write(json.decode(contentAsString));
// }
//
// String getPackageName() {
//   const _pubspecPackageName = 'name:';
//
//   final pubspec = File('pubspec.yaml');
//   if (pubspec.existsSync()) {
//     final pubspecContent = LineSplitter.split(pubspec.readAsStringSync());
//     for (final pubspecLine in pubspecContent) {
//       if (pubspecLine.contains('name:')) {
//         return pubspecLine.substring(_pubspecPackageName.length).trim();
//       }
//     }
//   }
//
//   return 'unknown package';
// }
//
// class SurfTestReport {
//   const SurfTestReport(this.projectId, this.tests);
//
//   final String projectId;
//   final Iterable<SurfTestClass> tests;
//
//   Map<String, Object> toJson() => {
//         'projectId': projectId,
//         'tests': tests.map((test) => test.toJson()).toList()
//       };
// }
//
// class SurfTestClass {
//   const SurfTestClass(this.name, this.methods);
//
//   final String name;
//   final Iterable<SurfTestData> methods;
//
//   Map<String, Object> toJson() => {
//         'name': name,
//         'methods': methods.map((method) => method.toJson()).toList()
//       };
// }
//
// class SurfTestData {
//   const SurfTestData(this.method, this.time);
//
//   final String method;
//   final double time;
//
//   Map<String, Object> toJson() => {'method': method, 'time': time};
// }
