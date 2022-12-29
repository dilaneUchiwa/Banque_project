import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Connexion avec google
  Future<UserCredential> signInWithGoogle() async {
    // Declenchement du flux d;authentification
    final googleUser = await _googleSignIn.signIn();

    //obtenir les details de la demande d'authentification

    final googleAuth = await googleUser!.authentication;

    // creer un nouvel identificatiom

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // une fois connecté , on renvoi l'identifiant de l'utilisateur connecté

    return await _auth.signInWithCredential(credential);
  }

  //retourne l'état de l'utiisateur en temps réel
  Stream<User?> get user => _auth.authStateChanges();

  // deconnexion du compte
  Future<void> signOut() async {
    _googleSignIn.signOut();
    return _auth.signOut();
  }
}
