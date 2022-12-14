import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello_to': 'Welcome to Gando',
          'skip': 'skip',
          'login': 'Login',
          'sign_up': 'Sign Up',
          'create_account': 'Create an account',
          'done': 'Done',
        },
        'fr_FR': {
          'hello_to': 'Bienvenue sur Gando',
          'skip': 'Passer',
          'login': 'Connexion',
          'sign_up': 'Inscription',
          'create_account': 'Créer un compte',
          'done': 'C\'est fait',
        }
      };
}
