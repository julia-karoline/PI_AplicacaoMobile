import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:app_ecojourney/src/pages/cadastro.dart';

void main() {
  group('Tela de Cadastro - Validações', () {
    testWidgets('Exibe erros ao submeter campos vazios',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CadastroScreen()));

      await tester.tap(find.byKey(const Key('cadastrar_button')));
      await tester.pump();

      expect(find.text('O campo nome é obrigatório'), findsOneWidget);
      expect(find.text('O campo e-mail é obrigatório'), findsOneWidget);
      expect(find.text('O campo senha é obrigatório'), findsOneWidget);
      expect(find.text('Confirme sua senha'), findsOneWidget);
    });

    testWidgets('Mostra erro de senhas diferentes',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CadastroScreen()));

      await tester.enterText(find.byKey(const Key('nome_field')), 'João');
      await tester.enterText(
          find.byKey(const Key('email_field')), 'joao@email.com');
      await tester.enterText(find.byKey(const Key('senha_field')), '123456');
      await tester.enterText(
          find.byKey(const Key('confirmar_senha_field')), '654321');
      await tester.tap(find.byKey(const Key('cadastrar_button')));
      await tester.pump();

      expect(find.text('As senhas não coincidem'), findsOneWidget);
    });

    testWidgets('Cadastro válido mas sem aceitar termos mostra snackbar',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CadastroScreen()));

      await tester.enterText(find.byKey(const Key('nome_field')), 'Maria');
      await tester.enterText(
          find.byKey(const Key('email_field')), 'maria@email.com');
      await tester.enterText(find.byKey(const Key('senha_field')), 'abcdef');
      await tester.enterText(
          find.byKey(const Key('confirmar_senha_field')), 'abcdef');
      await tester.tap(find.byKey(const Key('cadastrar_button')));
      await tester.pump();

      expect(
          find.text('Você precisa aceitar os termos de uso'), findsOneWidget);
    });

    testWidgets(
        'Mostra erro se a senha não contém letra maiúscula e caractere especial',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CadastroScreen()));

      await tester.enterText(find.byKey(const Key('nome_field')), 'Carlos');
      await tester.enterText(
          find.byKey(const Key('email_field')), 'carlos@email.com');
      await tester.enterText(
          find.byKey(const Key('senha_field')), 'senha123'); // inválida
      await tester.enterText(
          find.byKey(const Key('confirmar_senha_field')), 'senha123');
      await tester.tap(find.byKey(const Key('cadastrar_button')));
      await tester.pump();

      expect(
        find.text(
            'A senha deve conter pelo menos uma letra maiúscula e um caractere especial'),
        findsOneWidget,
      );
    });
  });
}
