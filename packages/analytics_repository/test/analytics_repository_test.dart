// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures

import 'package:analytics_repository/analytics_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class TestEvent extends Equatable with AnalyticsEventMixin {
  const TestEvent({required this.id});

  final String id;

  @override
  AnalyticsEvent get event {
    return AnalyticsEvent(
      'TestEvent',
      properties: <String, String>{'test-key': id},
    );
  }
}

void main() {
  group('AnalyticsRepository', () {
    late FirebaseAnalytics firebaseAnalytics;
    late AnalyticsRepository analyticsRepository;

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      analyticsRepository = AnalyticsRepository(firebaseAnalytics);

      when(
        () => firebaseAnalytics.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});
    });

    test('creates FirebaseAnalytics instance internally when not injected', () {
      expect(() => analyticsRepository, isNot(throwsException));
    });

    group('track', () {
      test('tracks event successfully', () {
        const event = AnalyticsEvent(
          'TestEvent',
          properties: <String, String>{'test-key': 'mock-id'},
        );

        analyticsRepository.track(event);

        verify(
          () => firebaseAnalytics.logEvent(
            name: event.name,
            parameters: event.properties,
          ),
        ).called(1);
      });
    });
  });
}
