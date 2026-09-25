import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/widgets/portfolio_buttons.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  static const nameFieldKey = Key('contact-name');
  static const emailFieldKey = Key('contact-email');
  static const messageFieldKey = Key('contact-message');
  static const submitButtonKey = Key('contact-submit');

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  var _autovalidateMode = AutovalidateMode.disabled;
  String? _status;

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      _status = valid ? ContactData.formReadyMessage : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Semantics(
          container: true,
          label: ContactData.formTitle,
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(ContactData.formTitle, style: textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xl),
                  TextFormField(
                    key: ContactForm.nameFieldKey,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    decoration: _fieldDecoration(ContactData.nameLabel),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ContactData.nameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    key: ContactForm.emailFieldKey,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.email],
                    decoration: _fieldDecoration(ContactData.emailLabel),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (!ContactData.emailPattern.hasMatch(text)) {
                        return ContactData.emailInvalid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    key: ContactForm.messageFieldKey,
                    minLines: 5,
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    decoration: _fieldDecoration(
                      ContactData.messageLabel,
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ContactData.messageRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PortfolioPrimaryButton(
                    key: ContactForm.submitButtonKey,
                    label: ContactData.sendMessage,
                    onPressed: _submit,
                  ),
                  if (_status != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        _status!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(
    String label, {
    bool alignLabelWithHint = false,
  }) {
    final colors = AppColors.of(context);
    final radius = BorderRadius.circular(AppSpacing.sm);
    final errorSide = BorderSide(color: colors.error);

    return InputDecoration(
      labelText: label,
      alignLabelWithHint: alignLabelWithHint,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: errorSide,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: errorSide,
      ),
    );
  }
}
