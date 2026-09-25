import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_links.dart';
import 'package:kiran_portfolio/core/utils/external_link.dart';

abstract final class ContactData {
  static const String eyebrow = 'CONTACT';
  static const String heading = "Let's build something great together.";
  static const String description =
      'Open to Flutter development opportunities, product collaborations, and interesting projects.';
  static const String introduction =
      "If you have a project, opportunity, or idea you'd like to discuss, feel free to reach out.";

  static const String emailLabel = 'Email';
  static const String linkedInLabel = 'LinkedIn';
  static const String githubLabel = 'GitHub';
  static const String locationLabel = 'Location';

  static const String linkedInValue = 'LinkedIn Profile';
  static const String githubValue = 'GitHub Profile';
  static const String locationValue = 'Punjab, India';

  static const String? email = AppLinks.email;

  static const String emailPlaceholder = 'your.email@example.com';

  static const String? linkedInUrl = AppLinks.linkedIn;
  static const String? githubUrl = AppLinks.github;

  static const String openLinkedInLabel = 'Open LinkedIn profile';
  static const String openGitHubLabel = 'Open GitHub profile';

  static const String preferEmail = 'Prefer email?';
  static const String emailMe = 'Email Me';
  static const String formTitle = 'Send a message';
  static const String nameLabel = 'Name';
  static const String messageLabel = 'Message';
  static const String sendMessage = 'Send Message';
  static const String formReadyMessage =
      'Contact form is ready to connect with a backend.';

  static const String copyEmailTooltip = 'Copy email';
  static const String copiedMessage = 'Copied to clipboard.';
  static const String copyFailedMessage = 'Unable to copy email.';
  static const String emailUnavailableMessage =
      'Email address is not configured yet.';
  static const String linkedInUnavailableMessage =
      'LinkedIn link is not configured yet.';
  static const String githubUnavailableMessage =
      'GitHub link is not configured yet.';

  static const String nameRequired = 'Enter your name.';
  static const String emailInvalid = 'Enter a valid email address.';
  static const String messageRequired = 'Enter a message.';

  static final RegExp emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? get configuredEmail {
    final value = email?.trim();
    if (value == null || value.isEmpty || value == emailPlaceholder) {
      return null;
    }
    if (value.toLowerCase().endsWith('@example.com')) {
      return null;
    }
    if (!emailPattern.hasMatch(value)) {
      return null;
    }
    return value;
  }

  static String get displayEmail => configuredEmail ?? emailUnavailableMessage;

  static bool get hasConfiguredEmail => configuredEmail != null;

  static String? get configuredLinkedInUrl => ExternalLink.httpUrl(linkedInUrl);

  static String? get configuredGithubUrl => ExternalLink.httpUrl(githubUrl);
}

abstract final class ContactActions {
  static Future<void> copyEmail(BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: ContactData.displayEmail));
      if (!context.mounted) {
        return;
      }
      _showNote(context, ContactData.copiedMessage);
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      _showNote(context, ContactData.copyFailedMessage);
    }
  }

  static void emailMe(BuildContext context) {
    final email = ContactData.configuredEmail;
    if (email == null) {
      _showNote(context, ContactData.emailUnavailableMessage);
      return;
    }
    ExternalLink.open(Uri(scheme: 'mailto', path: email).toString());
  }

  static void openLinkedIn(BuildContext context) {
    final url = ContactData.configuredLinkedInUrl;
    if (url == null) {
      _showNote(context, ContactData.linkedInUnavailableMessage);
      return;
    }
    ExternalLink.open(url);
  }

  static void openGitHub(BuildContext context) {
    final url = ContactData.configuredGithubUrl;
    if (url == null) {
      _showNote(context, ContactData.githubUnavailableMessage);
      return;
    }
    ExternalLink.open(url);
  }

  static void _showNote(BuildContext context, String message) {
    final colors = AppColors.of(context);
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.surfaceElevated,
          content: Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
          ),
        ),
      );
  }
}
