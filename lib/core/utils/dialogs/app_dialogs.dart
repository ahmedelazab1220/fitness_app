import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';
import '../l10n/locale_keys.g.dart';

class AppDialogs {
  // Private constructor to prevent instantiation
  AppDialogs._();

  // Show a loading dialog
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message ?? LocaleKeys.Loading.tr()),
            ],
          ),
        );
      },
    );
  }

  // Show a success dialog
  static Future<void> showSuccessDialog(
    BuildContext context, {
    required String message,
    String? description,
    String? firstButtonText,
    String? secondButtonText,
    VoidCallback? firstButtonAction,
    VoidCallback? secondButtonAction,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkgrey,
        titleTextStyle: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titlePadding: const EdgeInsets.symmetric(horizontal: 5.0),
        content: description != null
            ? Text(description, textAlign: TextAlign.center, maxLines: 2)
            : null,
        contentPadding: const EdgeInsets.only(
          left: 55,
          right: 55,
          top: 20,
          bottom: 35,
        ),
        contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white[AppColors.colorCode40],
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Row(
            spacing: 8.0,
            children: [
              if (secondButtonText != null)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                    ),
                    onPressed:
                        secondButtonAction ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(
                      secondButtonText,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                  ),
                  onPressed:
                      firstButtonAction ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text(
                    LocaleKeys.Ok.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
        title: Text(message),
      ),
    );
  }

  // Hide the loading dialog
  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  // Show a failure dialog
  static Future<void> showFailureDialog(
    BuildContext context, {
    required String message,
    String? description,
    String? firstButtonText,
    String? secondButtonText,
    VoidCallback? firstButtonAction,
    VoidCallback? secondButtonAction,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkgrey,
        titleTextStyle: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titlePadding: const EdgeInsets.symmetric(horizontal: 5.0),
        content: description != null
            ? Text(description, textAlign: TextAlign.center, maxLines: 2)
            : null,
        contentPadding: const EdgeInsets.only(
          left: 55,
          right: 55,
          top: 20,
          bottom: 35,
        ),
        contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white[AppColors.colorCode40],
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Row(
            spacing: 8.0,
            children: [
              if (secondButtonText != null)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkgrey,
                      side: const BorderSide(color: AppColors.orange),
                    ),
                    onPressed:
                        secondButtonAction ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(
                      secondButtonText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                  ),
                  onPressed:
                      firstButtonAction ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text(
                    LocaleKeys.Ok.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
        title: Text(message),
      ),
    );
  }

  // Show a confirmation dialog
  static Future<void> showConfirmationDialog(
    BuildContext context, {
    required String message,
    String? description,
    String? firstButtonText,
    String? secondButtonText,
    VoidCallback? firstButtonAction,
    VoidCallback? secondButtonAction,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkgrey,
        titlePadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        actionsPadding: const EdgeInsets.all(16.0),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        content: description != null
            ? Text(description, textAlign: TextAlign.center, maxLines: 2)
            : null,
        contentPadding: const EdgeInsets.only(
          left: 55,
          right: 55,
          top: 20,
          bottom: 35,
        ),
        contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white[AppColors.colorCode40],
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (firstButtonText != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkgrey,
                    side: const BorderSide(color: AppColors.orange),
                  ),
                  onPressed: firstButtonAction ?? () => Navigator.pop(context),
                  child: Text(
                    firstButtonText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                ),
                onPressed: secondButtonAction ?? () => Navigator.pop(context),
                child: Text(
                  secondButtonText ?? LocaleKeys.Ok.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
        title: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
