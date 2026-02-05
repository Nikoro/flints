import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:many_lints/src/rules/use_cubit_suffix.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() => defineReflectiveTests(UseCubitSuffixTest));
}

@reflectiveTest
class UseCubitSuffixTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = UseCubitSuffix();
    newPackage('bloc').addFile('lib/bloc.dart', r'''
class Cubit<State> {}
''');
    super.setUp();
  }

  Future<void> test_missing_cubit_suffix() async {
    await assertDiagnostics(
      r'''
import 'package:bloc/bloc.dart';
class Counter extends Cubit<int> {}
''',
      [lint(39, 7)],
    );
  }

  Future<void> test_has_cubit_suffix() async {
    await assertNoDiagnostics(r'''
import 'package:bloc/bloc.dart';
class CounterCubit extends Cubit<int> {}
''');
  }

  Future<void> test_not_a_cubit() async {
    await assertNoDiagnostics(r'''
class Counter {}
''');
  }
}
