import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get waterQualityReport {
    return Intl.message(
      'Water Quality Report',
      name: 'waterQualityReport',
      desc: 'Title for the Water Quality Report screen',
    );
  }

  String get mapTitle {
    return Intl.message(
      'Map',
      name: 'mapTitle',
      desc: 'Title for the Map screen',
    );
  }

  String get generalReport1 {
    return Intl.message(
      'CAUTION',
      name: 'generalReport1',
      desc: 'General Report text 1',
    );
  }

  String get generalReport2 {
    return Intl.message(
      'SAFE',
      name: 'generalReport2',
      desc: 'General Report text 2',
    );
  }

  String get generalReport3 {
    return Intl.message(
      'HAZARDOUS',
      name: 'generalReport3',
      desc: 'General Report text 3',
    );
  }

  String get tip {
    return Intl.message(
      'Tip:',
      name: 'tip',
      desc: 'Tip text',
    );
  }

  String get tip1 {
    return Intl.message(
      'Safe to drink and swim.',
      name: 'tip1',
      desc: 'Tip text',
    );
  }

  String get tip2 {
    return Intl.message(
      'Safe to drink but unsafe to swim.',
      name: 'tip2',
      desc: 'Tip text',
    );
  }

  String get tip3 {
    return Intl.message(
      'Unsafe to drink but safe to swim.',
      name: 'tip3',
      desc: 'Tip text',
    );
  }

  String get tip4 {
    return Intl.message(
      'Unsafe to drink and swim.',
      name: 'tip4',
      desc: 'Tip text',
    );
  }

  String get reportUpdate {
    return Intl.message(
      'Report last updated on',
      name: 'reportUpdate',
      desc: 'Report last updated on text',
    );
  }

  String get dissolvedOX {
    return Intl.message(
      'Dissolved\nOX',
      name: 'dissolvedOX',
      desc: 'Dissolved Oxygen text',
    );
  }

  String get turbidity {
    return Intl.message(
      'Turbidity',
      name: 'turbidity',
      desc: 'Turbidity text',
    );
  }

  String get nitrogen {
    return Intl.message(
      'Nitrogen',
      name: 'nitrogen',
      desc: 'Nitrogen text',
    );
  }

  String get phosph {
    return Intl.message(
      'Phosph',
      name: 'phosph',
      desc: 'Phosph text',
    );
  }
}
