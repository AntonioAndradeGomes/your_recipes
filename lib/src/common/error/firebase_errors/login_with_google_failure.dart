import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';

class LogInWithGoogleFailure extends CustomException {
  const LogInWithGoogleFailure({
    super.code = 'unknown',
    super.messageError = 'An unknown exception occurred.',
    super.customMessage = 'Um erro desconhecido aconteceu',
  });

  static LogInWithGoogleFailure abortLogin(String code) =>
      LogInWithGoogleFailure(
        code: code,
        messageError: 'Login process with Google was aborted',
        customMessage: 'Processo de login com o Google foi abortado',
      );

  factory LogInWithGoogleFailure.fromFirebaseException(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage:
              'Parece que você já possui uma conta associada a outro método de autenticação.',
        );
      case 'invalid-credential':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage:
              'Parece que ocorreu um problema com as credenciais fornecidas. Por favor, verifique suas informações e tente novamente.',
        );
      case 'operation-not-allowed':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage: 'Desculpe, a operação solicitada não é permitida.',
        );
      case 'user-disabled':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage: 'Sua conta está desativada.',
        );
      case 'user-not-found':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage:
              'Desculpe, não encontramos esse usuário em nosso sistema.',
        );
      case 'wrong-password':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage: 'A senha fornecida está incorreta.',
        );
      case 'invalid-verification-code':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
        );
      case 'invalid-verification-id':
        return LogInWithGoogleFailure(
          code: e.code,
          messageError: e.message,
          customMessage:
              'O código de verificação de credencial recebido é inválido.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}
