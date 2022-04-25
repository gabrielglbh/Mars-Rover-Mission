import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Language", () {
    testWidgets('Change to ES', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.spanishFlag));
      await tester.pump();

      expect(find.text("Parametrizar Mapa Aleatorio"), findsOneWidget);
    });

    testWidgets('Change to EN', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.englishFlag));
      await tester.pump();

      expect(find.text("Parameterize Random Map"), findsOneWidget);
    });
  });

  group("Walkthrough", () {
    testWidgets('7 x 7 Map Customization', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.staticMapButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.mrmMapTile10));
      await tester.pump();

      await tester.tap(find.byKey(Keys.mrmMapTile16));
      await tester.pump();

      await tester.tap(find.byKey(Keys.mapTileRover));
      await tester.pump();

      await tester.tap(find.byKey(Keys.mrmMapTile00));
      await tester.pump();

      await tester.fling(
          find.byKey(Keys.navigationTestMapPageView),
          const Offset(-250, 0),
          300
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionR));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.pump();

      await tester.tap(find.byKey(Keys.navigationBeginMissionTestMap));
      await tester.pumpAndSettle();

      expect(find.byKey(Keys.monitorSimulation), findsOneWidget);
    });

    testWidgets('Parametrized Map', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.randomMapButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Keys.parametrizedMapX), "7");
      await tester.enterText(find.byKey(Keys.parametrizedMapY), "8");
      await tester.pump();

      await tester.tap(find.byKey(Keys.parametrizedMapContinue));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Keys.parametrizedObstacles), "0");
      await tester.pump();

      await tester.tap(find.byKey(Keys.parametrizedObstaclesContinue));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Keys.parametrizedMapX), "5");
      await tester.enterText(find.byKey(Keys.parametrizedMapY), "6");
      await tester.pump();

      await tester.tap(find.byKey(Keys.parametrizedMapContinue));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.roverDirectionN));
      await tester.pump();

      await tester.tap(find.byKey(Keys.parametrizedDirectionContinue));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.tap(find.byKey(Keys.roverActionR));
      await tester.tap(find.byKey(Keys.roverActionF));
      await tester.pump();

      await tester.tap(find.byKey(Keys.navigationBeginMissionTestMap));
      await tester.pumpAndSettle();

      expect(find.byKey(Keys.monitorSimulation), findsOneWidget);
    });
  });
}
