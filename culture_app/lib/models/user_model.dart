import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;


  /*@override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }*/

  void signUp({@required Map<String, dynamic> userData, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: senha,
    ).then((user) async {
      firebaseUser = user.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }
  void signIn({@required String email, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha).then((user) async {
        firebaseUser = user.user;
        await _loadCurrentUser();

        onSuccess();
        isLoading = false;
        notifyListeners();

    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void update({@required Map<String, dynamic> userData, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(
      email: userData["email"],
      password: senha,
    ).then((user) async {
      firebaseUser = user.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(){

  }

  bool isLogged(){
    return firebaseUser !=  null;
  }

  Future<Null> _saveUserData (Map<String, dynamic> userData) async
  {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["nome"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
  
  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
}