import 'dart:async';

import 'package:app/app.dart';
import 'package:app/data/personal_state.dart';
import 'package:app/models/personal_notifier.dart';
import 'package:app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GuidePage extends HookConsumerWidget {
  const GuidePage({super.key});

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 1,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalNotifier = ref.watch(personalProvider.notifier);
    final guides = useState<List<Map<String, dynamic>>?>(null);

    final statePosition = useState<Position?>(null);

    useEffect(() {
      StreamSubscription<Position>? positionStream;
      Future(() async {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          await Geolocator.requestPermission();
        }

        //現在位置を更新し続ける
        positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position? position) {
          if (position == null) return;
          if (!context.mounted) return;
          statePosition.value = position;
        });
      });
      return positionStream?.cancel;
    }, const []);

    useEffect(() {
      double distance(double latitude, double longitude) {
        return Geolocator.distanceBetween(
          statePosition.value?.latitude ?? 0,
          statePosition.value?.longitude ?? 0,
          latitude,
          longitude,
        );
      }

      int mySortComparison(double a_la, double a_lo, double b_la, double b_lo) {
        final propertyA = distance(a_la, a_lo);
        final propertyB = distance(b_la, b_lo);
        if (propertyA < propertyB) {
          return -1;
        } else if (propertyA > propertyB) {
          return 1;
        } else {
          return 0;
        }
      }

      Future(() async {
        final pguides = await personalNotifier.getGuides();
        pguides.sort((a, b) => mySortComparison(
            a['latitude'], a['longitude'], b['latitude'], b['longitude']));
        guides.value = pguides;
        print(guides.value);
      });
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '案内人を探す',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text('近くにいる案内人'),
                  ],
                ),
              ),
            ),
            ...List.generate(
              guides.value?.length ?? 0,
              (index) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ProfileCard(
                    guides.value?[index]['name'] ?? 'aaa',
                    guides.value?[index]['nickname'] ?? 'bbb',
                    guides.value?[index]['description'] ?? 'ccc',
                    onTap: () {
                      //
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              const SizedBox(height: 32),
                              Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/imgs/kani.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Center(child: Text('【ユーザー名】さんに依頼しますか？')),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 37),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF7E7E7E),
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      side: const BorderSide(
                                        color: Color(0xFF7E7E7E),
                                      ),
                                    ),
                                    child: const Text('まだ検討中'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(width: 24),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7E7E7E),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      side: const BorderSide(
                                        color: Color(0xFF7E7E7E),
                                      ),
                                    ),
                                    child: const Text('依頼する'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(personalProvider.notifier)
                                          .setGuide(
                                              guides.value?[index]['uuid']);
                                      ref.read(appRouterProvider).go(
                                            '/guide/map',
                                            extra: PersonalState(
                                              name: guides.value?[index]
                                                      ['name'] ??
                                                  'test_name_aaa',
                                              longitude: guides.value?[index]
                                                      ['longitude'] ??
                                                  0.0,
                                              latitude: guides.value?[index]
                                                      ['latitude'] ??
                                                  0.0,
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 37),
                                ],
                              ),
                              const SizedBox(width: 32),
                            ],
                          );
                        },
                      );
                    },
                    medals: const ["a", "a", "a", "a", "a", "a"],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// プロフィールカード
class _ProfileCard extends HookConsumerWidget {
  final List<String> medals;
  final String userName;
  final String nickName;
  final String description;
  final VoidCallback? onTap;

  const _ProfileCard(this.userName, this.nickName, this.description,
      {required this.medals, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/imgs/kani.png'),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: medals
                        .map((medal) =>
                            SvgPicture.asset('assets/icons/medal.svg'))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      nickName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: subTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
