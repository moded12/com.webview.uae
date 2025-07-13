import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naat_app/constans.dart';
import 'package:rxdart/rxdart.dart';

import '../AdManager.dart';

class AudioOfflinePlayer extends StatefulWidget {
  @override
  _AudioOfflinePlayerState createState() => _AudioOfflinePlayerState();
}

class _AudioOfflinePlayerState extends State<AudioOfflinePlayer> {
  late AudioPlayer _player;
  String mp3Url = "";
  late TargetPlatform _platform;
  bool isplaying = false;
  String playingAudio = "Play Audio";
  List allFilesNames = [
    "surah1.mp3",
    "surah2.mp3",
    "surah3.mp3",
    "surah4.mp3",
    "surah5.mp3",
    "surah6.mp3",
    "surah7.mp3",
    "surah8.mp3",
    "surah9.mp3",
    "surah10.mp3",
    "surah11.mp3",
    "surah12.mp3",
    "surah13.mp3",
    "surah14.mp3",
    "surah15.mp3",
    "surah16.mp3",
    "surah17.mp3",
    "surah18.mp3",
    "surah19.mp3",
    "surah20.mp3",
    "surah21.mp3",
    "surah22.mp3",
    "surah23.mp3",
    "surah24.mp3",
    "surah25.mp3",
    "surah26.mp3",
    "surah27.mp3",
    "surah28.mp3",
    "surah29.mp3",
    "surah30.mp3",
    "surah31.mp3",
    "surah32.mp3",
    "surah33.mp3",
    "surah34.mp3",
    "surah35.mp3",
    "surah36.mp3",
    "surah37.mp3",
    "surah38.mp3",
    "surah39.mp3",
    "surah40.mp3",
    "surah41.mp3",
    "surah42.mp3",
    "surah43.mp3",
    "surah44.mp3",
    "surah45.mp3",
    "surah46.mp3",
    "surah47.mp3",
    "surah48.mp3",
    "surah49.mp3",
    "surah50.mp3",
    "surah51.mp3",
    "surah52.mp3",
    "surah53.mp3",
    "surah54.mp3",
    "surah55.mp3",
    "surah56.mp3",
    "surah57.mp3",
    "surah58.mp3",
    "surah59.mp3",
    "surah60.mp3",
    "surah61.mp3",
    "surah62.mp3",
    "surah63.mp3",
    "surah64.mp3",
    "surah65.mp3",
    "surah66.mp3",
    "surah67.mp3",
    "surah68.mp3",
    "surah69.mp3",
    "surah70.mp3",
    "surah71.mp3",
    "surah72.mp3",
    "surah73.mp3",
    "surah74.mp3",
    "surah75.mp3",
    "surah76.mp3",
    "surah77.mp3",
    "surah78.mp3",
    "surah79.mp3",
    "surah80.mp3",
    "surah81.mp3",
    "surah82.mp3",
    "surah83.mp3",
    "surah84.mp3",
    "surah85.mp3",
    "surah86.mp3",
    "surah87.mp3",
    "surah88.mp3",
    "surah89.mp3",
    "surah90.mp3",
    "surah91.mp3",
    "surah92.mp3",
    "surah93.mp3",
    "surah94.mp3",
    "surah95.mp3",
    "surah96.mp3",
    "surah97.mp3",
    "surah98.mp3",
    "surah99.mp3",
    "surah100.mp3",
    "surah101.mp3",
    "surah102.mp3",
    "surah103.mp3",
    "surah104.mp3",
    "surah105.mp3",
    "surah106.mp3",
    "surah107.mp3",
    "surah108.mp3",
    "surah109.mp3",
    "surah110.mp3",
    "surah111.mp3",
    "surah112.mp3",
    "surah113.mp3",
    "surah114.mp3",
  ];
  List allSoundsNames = [
    "الفاتحة",
    "البقرة",
    "آل عمران",
    "النساء",
    "المائدة",
    "الأنعام",
    "الأعراف",
    "الأنفال",
    "التوبة",
    "يونس",
    "هود",
    "يوسف",
    "الرعد",
    "ابراهيم",
    "الحجر",
    "النحل",
    "الإسراء",
    "الكهف",
    "مريم",
    "طه",
    "الأنبياء",
    "الحج",
    "المؤمنون",
    "النور",
    "الفرقان",
    "الشعراء",
    "النمل",
    "القصص",
    "العنكبوت",
    "الروم",
    "لقمان",
    "السجدة",
    "الأحزاب",
    "سبإ",
    "فاطر",
    "يس",
    "الصافات",
    "ص",
    "الزمر",
    "غافر",
    "فصلت",
    "الشورى",
    "الزخرف",
    "الدخان",
    "الجاثية",
    "الأحقاف",
    "محمد",
    "الفتح",
    "الحجرات",
    "ق",
    "الذاريات",
    "الطور",
    "النجم",
    "القمر",
    "الرحمن",
    "الواقعة",
    "الحديد",
    "المجادلة",
    "الحشر",
    "الممتحنة",
    "الصف",
    "الجمعة",
    "المنافقون",
    "التغابن",
    "الطلاق",
    "التحريم",
    "الملك",
    "القلم",
    "الحاقة",
    "المعارج",
    "نوح",
    "الجن",
    "المزمل",
    "المدثر",
    "القيامة",
    "الانسان",
    "المرسلات",
    "النبإ",
    "النازعات",
    "عبس",
    "التكوير",
    "الإنفطار",
    "المطففين",
    "الإنشقاق",
    "البروج",
    "الطارق",
    "الأعلى",
    "الغاشية",
    "الفجر",
    "البلد",
    "الشمس",
    "الليل",
    "الضحى",
    "الشرح",
    "التين",
    "العلق",
    "القدر",
    "البينة",
    "الزلزلة",
    "العاديات",
    "القارعة",
    "التكاثر",
    "العصر",
    "الهمزة",
    "الفيل",
    "قريش",
    "الماعون",
    "الكوثر",
    "الكافرون",
    "النصر",
    "المسد",
    "الإخلاص",
    "الفلق",
    "الناس"
  ];
  int _addedCount = 0;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();
    isplaying = false;
  }

  List<AudioSource> getList() {
    List<AudioSource> listAudios =[];
    for (int i = 0; i < allSoundsNames.length; i++) {
      String audioFile = allFilesNames[i];
      String audioFileName = "سُورَة ";
      audioFileName = audioFileName + allSoundsNames[i];
      listAudios.add(
          AudioSource.uri(Uri.parse("asset:///assets/audiofiles/$audioFile"),
              tag: AudioMetadata(
                title: audioFileName, album: '', artwork: '',
              )));
    }
    return listAudios;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: allSoundsNames.length,
                itemBuilder: (BuildContext context, int index) {
                  int currentSurah = index + 1;
                  String surah = allSoundsNames[index];
                  String mSurah = "سُورَة‎";

                  return Column(
                    children: [
                      // showNativeBannerAd(),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                        child: Ink(
                          child: Card(
                            color: AdManager.getNeumorphicBackgroundColor(),
                            elevation: 18.0,
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  showAdmobFullScreenAds();
                                  playingAudio =
                                      "" + mSurah + ' ' + allSoundsNames[index];
                                  setState(() {
                                    isplaying = false;
                                  });

                                  mp3Url = 'assets/audiofiles/' +
                                      allFilesNames[index];
                                  isplaying = true;
                                  if (_player != null &&
                                      _player.playerState.playing == true) {
                                    _player.stop();
                                  }
                                  playAudioJustPlayer(mp3Url);

                                  isplaying = true;
                                },
                                contentPadding: EdgeInsets.all(15),
                                title: Center(
                                  child: Text(
                                    mSurah + ' ' + allSoundsNames[index],
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.arvo(
                                        textStyle: TextStyle(
                                          color: AdManager.getTextColor(),
                                          fontSize: 23.0,
                                        )),
                                  ),
                                ),
                                /* subtitle: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 16.0,
                                        fontFamily: "Raleway"),
                                    maxLines: 2,),
                                ),*/
                                trailing: Text(
                                  ".$currentSurah",
                                  style: GoogleFonts.arvo(
                                      textStyle: TextStyle(
                                        color: AdManager.getTextColor(),
                                        fontSize: 22.0,
                                      )),
                                ),
                                leading: Card(
                                  elevation: 18.0,
                                  color: Color(0x000000),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.ondemand_video,
                                      color: AdManager.getNeumorphicBoxShadowColorDark(),
                                    ),
                                    backgroundColor: AdManager.getTextColor(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          isplaying
              ? Container(
            color: AdManager.getNeumorphicBackgroundColor(),
            child: Column(
              children: [
                StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence?.isEmpty ?? true)
                      return SizedBox(
                        height: 0,
                      );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            playingAudio ?? '',
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.arvo(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                )),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<Duration?>(
                  stream: _player.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;
                    return StreamBuilder<PositionData>(
                      stream: Rx.combineLatest2<Duration, Duration,
                          PositionData>(
                          _player.positionStream,
                          _player.bufferedPositionStream,
                              (position, bufferedPosition) =>
                              PositionData(position, bufferedPosition)),
                      builder: (context, snapshot) {
                        final positionData = snapshot.data ??
                            PositionData(Duration.zero, Duration.zero);
                        var position =
                            positionData.position ?? Duration.zero;
                        if (position > duration) {
                          position = duration;
                        }
                        var bufferedPosition =
                            positionData.bufferedPosition ??
                                Duration.zero;
                        if (bufferedPosition > duration) {
                          bufferedPosition = duration;
                        }
                        return SeekBar(
                          duration: duration,
                          position: position,
                          bufferedPosition: bufferedPosition,
                          onChangeEnd: (newPosition) {
                            _player.seek(newPosition);
                          }, onChanged: (Duration value) {  },
                        );
                      },
                    );
                  },
                ),
                ControlButtons(_player),
              ],
            ),
          )
              : Container(
            width: 0,
            height: 0,
          ),
        ],
      ),
    );
  }

  Future<void> playAudioJustPlayer(String mp3url) async {
    _player = AudioPlayer();
    var duration = await _player.setAsset(mp3url);

    _player.play();
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder<LoopMode>(
            stream: player.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              const icons = [
                Icon(Icons.repeat, color: Colors.white),
                Icon(Icons.repeat, color: Colors.white),
                Icon(Icons.repeat_one, color: Colors.white),
              ];
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);
              return IconButton(
                icon: icons[index],
                onPressed: () {
                  player.setLoopMode(cycleModes[
                  (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              _showSliderDialog(
                context: context,
                title: "Adjust volume",
                divisions: 10,
                min: 0.0,
                max: 1.0,
                stream: player.volumeStream,
                onChanged: player.setVolume,
              );
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) => IconButton(
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
              onPressed: player.hasPrevious ? player.seekToPrevious : null,
            ),
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  width: 54.0,
                  height: 54.0,
                  child: CircularProgressIndicator(),
                );
              } else if (playing != true) {
                return IconButton(
                  icon: Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 64.0,
                  onPressed: player.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: Icon(Icons.pause_circle_filled_rounded,
                      color: Colors.white),
                  iconSize: 64.0,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.replay_circle_filled, color: Colors.white),
                  iconSize: 54.0,
                  onPressed: () => player.seek(Duration.zero,
                      index: player.effectiveIndices?.first),
                );
              }
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) => IconButton(
              icon: Icon(Icons.skip_next, color: Colors.white),
              onPressed: player.hasNext ? player.seekToNext : null,
            ),
          ),
          StreamBuilder<double>(
            stream: player.speedStream,
            builder: (context, snapshot) => IconButton(
              icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                _showSliderDialog(
                  context: context,
                  title: "Adjust speed",
                  divisions: 10,
                  min: 0.5,
                  max: 1.5,
                  stream: player.speedStream,
                  onChanged: player.setSpeed,
                );
              },
            ),
          ),
          StreamBuilder<bool>(
            stream: player.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              final shuffleModeEnabled = snapshot.data ?? false;
              return IconButton(
                icon: shuffleModeEnabled
                    ? Icon(Icons.shuffle, color: Colors.white)
                    : Icon(Icons.shuffle, color: Colors.white),
                onPressed: () async {
                  final enable = !shuffleModeEnabled;
                  if (enable) {
                    await player.shuffle();
                  }
                  await player.setShuffleModeEnabled(enable);
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: TextStyle(color: Colors.white)),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

_showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({required this.album, required this.title, required this.artwork});
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required  Animation<double> activationAnimation,
        required  Animation<double> enableAnimation,
        required  bool isDiscrete,
        required  TextPainter labelPainter,
        required  RenderBox parentBox,
        required  SliderThemeData sliderTheme,
        required  TextDirection textDirection,
        required  double value,
        required  double textScaleFactor,
        required  Size sizeWithOverflow,
      }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}

// scafllod with background image with transparent rows
/*
Scaffold(
resizeToAvoidBottomInset: false,
body: Container(
decoration: BoxDecoration(
image: DecorationImage(
image: AssetImage("assets/images/bg.png"),
fit: BoxFit.cover,
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Expanded(

child: Container(
child: ListView.builder(
scrollDirection: Axis.vertical,

itemCount: allSoundsNames.length,
itemBuilder: (BuildContext context, int index) {
int currentSurah = index+1;
String surah = allSoundsNames[index];
String mSurah = "سُورَة‎";

return Column(children: [
// showNativeBannerAd(),
Container(
padding: EdgeInsets.only(
left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
child: Ink(
child: Card(
color: Color(0xFF80000000),
elevation: 18.0,
child: Container(
child: ListTile(
onTap: () {

playingAudio = ""+ mSurah+' '+allSoundsNames[index];
setState(() {

isplaying = false;
});

mp3Url = 'assets/audiofiles/'+allFilesNames[index];
isplaying = true;
if(_player!=null&&_player.playerState.playing==true){
_player.pause();

}
playAudioJustPlayer(mp3Url);

isplaying = true;





},
contentPadding: EdgeInsets.all(15),
title: Center(
child: Text(
mSurah+' '+allSoundsNames[index],
textDirection: TextDirection.rtl,
style: GoogleFonts.arvo(textStyle: TextStyle(
color: Colors.white,
fontSize: 23.0,
)),
),
),
*/
/* subtitle: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16.0,
                                          fontFamily: "Raleway"),
                                      maxLines: 2,),
                                  ),*/ /*

trailing:  Text(
".$currentSurah",
style: GoogleFonts.arvo(textStyle: TextStyle(
color: Colors.white,
fontSize: 22.0,
)),
),
leading: Card(
elevation: 18.0,
color: Colors.white,
child: Container(width: 0.0,),
),
),
),
),
),
)
],);


},
),
),
),
isplaying?
Container(

color: Color(0xFF000000),
child: Column(
children: [
StreamBuilder<SequenceState>(
stream: _player.sequenceStateStream,
builder: (context, snapshot) {
final state = snapshot.data;
if (state?.sequence?.isEmpty ?? true) return SizedBox(height: 0,);
final metadata = state.currentSource.tag as AudioMetadata;
return Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Text( playingAudio ?? '',  textDirection: TextDirection.rtl,
style: GoogleFonts.arvo(
textStyle: TextStyle(
color: Colors.white,
fontSize: 18.0,
)),),
],
);
},
),
StreamBuilder<Duration>(
stream: _player.durationStream,
builder: (context, snapshot) {
final duration = snapshot.data ?? Duration.zero;
return StreamBuilder<PositionData>(
stream: Rx.combineLatest2<Duration, Duration, PositionData>(
_player.positionStream,
_player.bufferedPositionStream,
(position, bufferedPosition) =>
PositionData(position, bufferedPosition)),
builder: (context, snapshot) {
final positionData = snapshot.data ??
PositionData(Duration.zero, Duration.zero);
var position = positionData.position ?? Duration.zero;
if (position > duration) {
position = duration;
}
var bufferedPosition =
positionData.bufferedPosition ?? Duration.zero;
if (bufferedPosition > duration) {
bufferedPosition = duration;
}
return SeekBar(
duration: duration,
position: position,
bufferedPosition: bufferedPosition,
onChangeEnd: (newPosition) {
_player.seek(newPosition);
},
);
},
);
},
),
ControlButtons(_player),
],
),
):Container(width: 0,height: 0,),

],
),
),
)*/
