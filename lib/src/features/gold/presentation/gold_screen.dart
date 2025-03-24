import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_gold_rate/src/features/gold/data/fake_gold_api.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Platzhalter für den Goldpreis
    /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
    const double goldPrice = 69.22;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: getGoldPriceStream(),
                  builder: (context, snapshot) {
                    print('${snapshot.data} and ${snapshot.connectionState}');
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.active) {
                      return Text(
                        NumberFormat.simpleCurrency(locale: 'de_DE')
                            .format(snapshot.data),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      );
                    } else if (snapshot.connectionState !=
                        ConnectionState.active) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Icon(Icons.error);
                    }
                  }),
              // TODO: Verwende einen StreamBuilder, um den Goldpreis live anzuzeigen
              // statt des konstanten Platzhalters
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
