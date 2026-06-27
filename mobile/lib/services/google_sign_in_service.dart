import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '851507782363-4favlf24174r6572rdc158ochos8t4f8.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print('Google Sign-Out Error: $error');
    }
  }

  static Future<GoogleSignInAccount?> getCurrentUser() async {
    try {
      return await _googleSignIn.signInSilently();
    } catch (error) {
      print('Get Current User Error: $error');
      return null;
    }
  }

  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onSignInSuccess;
  final VoidCallback? onSignInError;

  const GoogleSignInButton({
    super.key,
    this.onSignInSuccess,
    this.onSignInError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          final account = await GoogleSignInService.signIn();
          if (account != null) {
            onSignInSuccess?.call();
          } else {
            onSignInError?.call();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/google_logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text('mobile.auto.sign_in_with_google'.tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleUserProfile extends StatelessWidget {
  final GoogleSignInAccount user;
  final VoidCallback? onSignOut;

  const GoogleUserProfile({
    super.key,
    required this.user,
    this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoUrl ?? ''),
          ),
          SizedBox(height: 12),
          Text(
            user.displayName ?? 'mobile.leftovers.unknown_user'.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await GoogleSignInService.signOut();
              onSignOut?.call();
            },
            child: Text('mobile.auto.sign_out'.tr()),
          ),
        ],
      ),
    );
  }
}

// Usage example
class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await GoogleSignInService.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mobile.auto.google_sign_in'.tr()),
      ),
      body: Center(
        child: _currentUser == null
            ? GoogleSignInButton(
                onSignInSuccess: () async {
                  final user = await GoogleSignInService.getCurrentUser();
                  setState(() {
                    _currentUser = user;
                  });
                  if(mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('mobile.auto.sign_in_successful'.tr())),
                    );
                  }
                },
                onSignInError: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('mobile.auto.sign_in_failed'.tr())),
                  );
                },
              )
            : GoogleUserProfile(
                user: _currentUser!,
                onSignOut: () {
                  setState(() {
                    _currentUser = null;
                  });
                },
              ),
      ),
    );
  }
}
