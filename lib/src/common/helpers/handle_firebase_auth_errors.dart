/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_recipes/src/common/error/custom_exception.dart';*/
/*
CustomException handleAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'Parece que você já possui uma conta associada a outro método de autenticação.',
      );

    case 'invalid-credential':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'Parece que ocorreu um problema com as credenciais fornecidas. Por favor, verifique suas informações e tente novamente.',
      );
    case 'operation-not-allowed':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'Desculpe, a operação solicitada não é permitida.',
      );
    case 'user-disabled':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'Sua conta está desativada.',
      );

    case 'wrong-password':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'A senha fornecida está incorreta.',
      );

    case 'weak-password':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'A senha fornecida é fraca.',
      );
    case 'network-request-failed':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'Houve uma falha na comunicação com o servidor. Verifique sua conexão com a internet e tente novamente.',
      );
    case 'too-many-requests':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'Tente novamente mais tarde.',
      );
    case 'invalid-verification-code':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'O código de verificação fornecido não é válido. Verifique o código e tente novamente.',
      );
    case 'invalid-verification-id':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'O ID de verificação fornecido não é válido. Tente novamente ou solicite um novo código.',
      );
    case 'email-already-in-use':
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message:
            'Este endereço de e-mail já está em uso por outra conta. Se você já possui uma conta, tente fazer login. Caso contrário, utilize um endereço de e-mail diferente.',
      );
    default:
      return CustomException(
        code: e.code,
        messageFirebase: e.message,
        message: 'Erro desconhecido aconteceu. Tente novamente mais tarde!',
      );
  }
}
*/