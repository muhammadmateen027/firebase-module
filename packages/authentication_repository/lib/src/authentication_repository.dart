import 'dart:async';
import 'dart:math' hide log;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage_service/firebase_storage_service.dart';

const _usersCollection = 'users';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseStorageService? firebaseStorageService,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseStorageService =
            firebaseStorageService ?? FirebaseStorageService();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseStorageService _firebaseStorageService;

  /// get user collection instance to perform CRUD operations
  final userCollection =
      FirebaseFirestore.instance.collection(_usersCollection);

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.anonymous] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.anonymous : firebaseUser.toUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw SignUpFailure(error, code: error.code);
    } catch (error, stackTrace) {
      throw SignUpFailure(error, stackTrace: stackTrace);
    }
  }

  /// Check if email exists and registered
  ///
  /// Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await _firebaseAuth.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty, Return true because there is an existing
      // user using the email address
      // Return false because email address is not in use
      return list.isNotEmpty;
    } catch (error, stackTrace) {
      throw EmailExistingFailure(error, stackTrace);
    }
  }

  /// Update current user email.
  ///
  /// Throws a [UpdateFailure] if an exception occurs.
  Future<void> updateEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _firebaseAuth.currentUser!.email!,
        password: currentPassword,
      );

      await userCredential.user!.updateEmail(newEmail);
      return;
    } catch (error, stackTrace) {
      throw UpdateFailure(error, stackTrace);
    }
  }

  /// Update current user's password.
  ///
  /// Throws a [UpdateFailure] if an exception occurs.
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: _firebaseAuth.currentUser!.email!,
        password: currentPassword,
      );
      if (currentPassword == newPassword) {
        throw FirebaseAuthException(
            code: 'password-same',
            message: "Current Password and New password can't be same");
      }
      await authResult.user!.updatePassword(newPassword);
      return;
    } catch (error, stackTrace) {
      throw UpdateFailure(error, stackTrace);
    }
  }

  /// Checks if a phone number exists on users collection.
  Future<bool> isExistentUserPhone(String phone) async {
    try {
      final querySnapshot =
          await userCollection.where('phone', isEqualTo: phone).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Adds new user data. Call when a new user is created.
  Future<void> addUserData(User user, String phone) async {
    try {
      final CollectionReference users = userCollection;
      await users.doc(user.id).set({
        'phone': phone,
      });
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Checks if a user has a unique user id.
  Future<bool> isUserWithHandle(User user) async {
    try {
      return userCollection.doc(user.id).get().then<bool>((value) {
        if (value.data() != null) {
          return value.data()!['handle'] != null;
        }
        return false;
      });
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Checks if a specific handle exists on users collection.
  Future<bool> isExistentHandle(String handle) async {
    try {
      return userCollection
          .where('handle', isEqualTo: handle)
          .get()
          .then<bool>((querySnapshot) => querySnapshot.docs.isNotEmpty);
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Adds newId as the user's handle.
  Future<void> createHandle(User user, String handle, String fullName) async {
    try {
      final randomIndex = Random().nextInt(4) + 1;
      final pictureName = 'users/default_profile_picture$randomIndex.png';
      final pictureURL = await _firebaseStorageService.downloadURL(pictureName);

      final newEntry = {
        'handle': handle,
        'full_name': fullName,
        'profile_picture': pictureURL,
      };

      await userCollection.doc(user.id).set(newEntry, SetOptions(merge: true));
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Adds newId as the user's handle.
  Future<void> updateHandle(User user, String handle) async {
    try {
      final newEntry = {'handle': handle};
      await userCollection.doc(user.id).set(newEntry, SetOptions(merge: true));
    } catch (error, stackTrace) {
      throw FirestoreFailure(error, stackTrace);
    }
  }

  /// Sends a password reset link to the provided email
  ///
  /// Throws a [ResetPasswordFailure] if an exception occurs.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error, stackTrace) {
      throw ResetPasswordFailure(error, stackTrace);
    }
  }

  /// Signs in with a phone credential
  Future<User> signInWithPhoneCredential(PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user!.toUser;
    } catch (error, stackTrace) {
      throw LogInWithPhoneNumberFailure(error, stackTrace);
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw LogInWithEmailAndPasswordFailure(error, code: error.code);
    } catch (error, stackTrace) {
      throw LogInWithEmailAndPasswordFailure(error, stackTrace: stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (error, stackTrace) {
      throw LogOutFailure(error, stackTrace);
    }
  }

  /// Delete the current user
  Future<void> removeUser() async {
    try {
      await firebase_auth.FirebaseAuth.instance.currentUser!.delete();
      await firebase_auth.FirebaseAuth.instance.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}
