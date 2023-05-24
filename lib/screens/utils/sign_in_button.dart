import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invert_colors/invert_colors.dart';
import '../../services/config.dart';

class SignInButton extends StatelessWidget {
  final String? img;
  final String provider;
  final Function onPressed;
  final bool invert;
  final String prefix;
  final IconData? icon;
  const SignInButton(
      {super.key,
      this.img,
      required this.provider,
      required this.onPressed,
      this.invert = false,
      this.prefix = 'Sign in with',
      this.icon});

  @override
  Widget build(BuildContext context) {
    // assert that exactly one of img or icon is not null
    assert((img == null) != (icon == null));

    var logo = img != null
        ? SvgPicture.asset(
            img!,
            height: 30,
          )
        : Icon(icon,
            size: 30,
            color: themeNotifier.isDark ? Colors.black : Colors.white);

    return ElevatedButton(
      onPressed: () async {
        await onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        // 🤡 ugly ass code to keep this responsive to theme
        backgroundColor: themeNotifier.isDark
            ? Theme.of(context)
                .colorScheme
                .primaryContainer
                .withBlue(255)
                .withGreen(255)
                .withRed(255)
            : Theme.of(context)
                .colorScheme
                .primaryContainer
                .withBlue(0)
                .withGreen(0)
                .withRed(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            invert && themeNotifier.isDark
                ? InvertColors(
                    child: logo,
                  )
                : logo,
            const Padding(padding: EdgeInsets.only(left: 8)),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$prefix $provider',
                  style: TextStyle(
                    fontSize: 18,
                    color: themeNotifier.isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
