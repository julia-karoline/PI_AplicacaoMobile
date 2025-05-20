import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecojourney/src/pages/login.dart'; 
import 'package:flutter/material.dart';

void main() {
  group('TelaLogin Widget Tests', () {
    late TelaLoginState telaLoginState;

    setUp(() {
      telaLoginState = TelaLoginState();
    });

    group('Validação do Campo de E-mail', () {
      test('E-mail vazio retorna erro', () {
        expect(telaLoginState.validateEmail(null), 'O campo e-mail é obrigatório');
        expect(telaLoginState.validateEmail(''), 'O campo e-mail é obrigatório');
      });

      test('E-mail com formato inválido retorna erro', () {
        expect(telaLoginState.validateEmail('teste'), 'Digite um e-mail válido');
        expect(telaLoginState.validateEmail('teste@'), 'Digite um e-mail válido');
        expect(telaLoginState.validateEmail('teste@.com'), 'Digite um e-mail válido');
        expect(telaLoginState.validateEmail('@email.com'), 'Digite um e-mail válido');
        expect(telaLoginState.validateEmail('teste@email'), 'Digite um e-mail válido');
      });

      test('E-mail com formato válido não retorna erro', () {
        expect(telaLoginState.validateEmail('teste@gmail.com'), isNull);
        expect(telaLoginState.validateEmail('teste.123@dominio.com.br'), isNull);
        expect(telaLoginState.validateEmail('teste-abc@sub.dominio.net'), isNull);
      });
    });

    group('Validação do Campo de Senha', () {
      test('Senha vazia retorna erro', () {
        expect(telaLoginState.validatePassword(null), 'O campo senha é obrigatório');
        expect(telaLoginState.validatePassword(''), 'O campo senha é obrigatório');
      });

      test('Senha com menos de 6 caracteres retorna erro', () {
        expect(telaLoginState.validatePassword('123'), 'A senha deve ter pelo menos 6 caracteres');
        expect(telaLoginState.validatePassword('abcd'), 'A senha deve ter pelo menos 6 caracteres');
        expect(telaLoginState.validatePassword('12345'), 'A senha deve ter pelo menos 6 caracteres');
      });

      test('Senha com 6 ou mais caracteres não retorna erro', () {
        expect(telaLoginState.validatePassword('123456'), isNull);
        expect(telaLoginState.validatePassword('abcdef'), isNull);
        expect(telaLoginState.validatePassword('senha_longa'), isNull);
      });
    });

    group('Interação com a Tela', () {
      testWidgets('Ao submeter com e-mail inválido, mensagem de erro é exibida', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: TelaLogin()));

        final emailField = find.byKey(const Key('email_field'));
        final passwordField = find.byKey(const Key('password_field'));
        final loginButton = find.byKey(const Key('login_button'));

        await tester.enterText(emailField, 'teste'); // e-mail inválido
        await tester.enterText(passwordField, '123456'); // senha válida
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('Digite um e-mail válido'), findsOneWidget);
      });

      testWidgets('Ao submeter com senha curta, mensagem de erro é exibida', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: TelaLogin()));

        final emailField = find.byKey(const Key('email_field'));
        final passwordField = find.byKey(const Key('password_field'));
        final loginButton = find.byKey(const Key('login_button'));

        await tester.enterText(emailField, 'teste@email.com'); // e-mail válido
        await tester.enterText(passwordField, '123'); // senha curta
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('A senha deve ter pelo menos 6 caracteres'), findsOneWidget);
      });

      testWidgets('Ao submeter com campos vazios, ambas as mensagens de erro são exibidas', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: TelaLogin()));

        final loginButton = find.byKey(const Key('login_button'));

        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('O campo e-mail é obrigatório'), findsOneWidget);
        expect(find.text('O campo senha é obrigatório'), findsOneWidget);
      });
    });
  });
}