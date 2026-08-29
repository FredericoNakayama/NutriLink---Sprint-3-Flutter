// Smoke test do NutriLink: garante que o app inicia na splash e apresenta
// a marca.

import 'package:flutter_test/flutter_test.dart';

import 'package:sprint3_nutrilink/app.dart';

void main() {
  testWidgets('App inicia exibindo a marca NutriLink', (tester) async {
    await tester.pumpWidget(const NutriLinkApp());

    // A splash exibe o nome do app.
    expect(find.text('NutriLink'), findsOneWidget);
  });
}
