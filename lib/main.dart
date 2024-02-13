import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
      ),
      home: MbtiCompatibilityScreen(),
    );
  }
}

class MbtiCompatibilityScreen extends StatefulWidget {
  const MbtiCompatibilityScreen({Key? key}) : super(key: key);

  @override
  State<MbtiCompatibilityScreen> createState() =>
      _MbtiCompatibilityScreenState();
}

class _MbtiCompatibilityScreenState extends State<MbtiCompatibilityScreen> {
  final List<String> mbtiTypes = [
    'ESTJ',
    'ESTP',
    'ESFJ',
    'ESFP',
    'ENTJ',
    'ENTP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISTP',
    'ISFJ',
    'ISFP',
    'INTJ',
    'INTP',
    'INFJ',
    'INFP'
  ];

  final List<Color> color = [
    Colors.red,
    Colors.orange,
    Colors.yellow[700]!, // Darker yellow for better text visibility
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.yellow[700]!, // Darker yellow for better text visibility
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final Map<String, Map<String, List<String>>> mbtiCombinations = {
    "ESTJ": {
      "best": ["ISFP", "ISTP"],
      "good": ["ISFJ", "ESFJ", "ISTJ", "ESTJ"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ESTP": {
      "best": ["ISFJ", "ISTJ"],
      "good": ["INTJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ESFJ": {
      "best": ["ISFP", "ISTP"],
      "good": ["ISFJ", "ESFJ", "ISTJ", "ESTJ"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ESFP": {
      "best": ["ISFJ", "ISTJ"],
      "good": ["INTJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ENTJ": {
      "best": ["INFP", "INTP"],
      "good": ["ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "ENTP"],
      "bad": []
    },
    "ENTP": {
      "best": ["INFJ", "INTJ"],
      "good": ["INFP", "ENFP", "ENFJ", "ENTJ", "INTP", "ENTP"], // Fixed here
      "bad": []
    },
    "ENFJ": {
      "best": ["INFP", "ISFP"],
      "good": ["ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["ESFP", "ISTP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    },
    "ENFP": {
      "best": ["INFJ", "INTJ"],
      "good": ["INFP", "ENFP", "ENFJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["ISFP", "ESFP", "ISTP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    },
    "ISTJ": {
      "best": ["ESFP", "ESTP"],
      "good": ["ISFJ", "ESFJ", "ISTJ", "ESTJ"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ISTP": {
      "best": ["ESFJ", "ESTJ"],
      "good": ["INTJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ISFJ": {
      "best": ["ESFP", "ESTP"],
      "good": ["ISFJ", "ESFJ", "ISTJ", "ESTJ"],
      "bad": ["INFP", "ENFP", "INFJ", "ENFJ"]
    },
    "ISFP": {
      "best": ["ENFJ", "ESFJ", "ESTJ"],
      "good": ["INTJ", "ENTJ", "INTP", "ENTP"],
      "bad": ["INFP", "ENFP", "INFJ"]
    },
    "INTJ": {
      "best": ["ENFP", "ENTP"],
      "good": ["INFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP"],
      "bad": []
    },
    "INTP": {
      "best": ["ENTJ", "ESTJ"],
      "good": ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "INTP", "ENTP"],
      "bad": []
    },
    "INFJ": {
      "best": ["ENFP", "ENTP"],
      "good": ["INFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP"],
      "bad": ["ISFP", "ESFP", "ISTP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    },
    "INFP": {
      "best": ["ENTJ", "ESTJ"],
      "good": ["INFP", "ENFP", "INFJ", "INTJ", "INTP", "ENTP"],
      "bad": ["ISFP", "ESFP", "ISTP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    }
  };

  String? _selectedMbti1;
  String? _selectedMbti2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MBTI Combination'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Text('MBTI 성향 조합 테스트',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: Text(
                  '두 MBTI 성향을 선택하세요',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: mbtiTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildMbtiTile(
                          mbtiTypes[index], color[index % color.length]);
                    },
                  ))
            ],
          ),
        ));
  }

  Widget _buildMbtiTile(String mbti, Color mbtiColor) {
    bool isSelected = (mbti == _selectedMbti1 || mbti == _selectedMbti2);

    return GestureDetector(
      onTap: () {
        _handleMbtiSelection(mbti);
      },
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.0, end: isSelected ? 0.85 : 1.0),
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          builder: (BuildContext context, double value, Widget? child) {
            return Transform.scale(
              scale: value,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [
                          mbtiColor.withOpacity(isSelected ? 0.6 : 0.8),
                          mbtiColor.withOpacity(isSelected ? 0.8 : 1.0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    mbti,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _handleMbtiSelection(String mbtiType) {
    if (_selectedMbti1 == null) {
      setState(() {
        _selectedMbti1 = mbtiType;
      });
    } else if (_selectedMbti2 == null) {
      setState(() {
        _selectedMbti2 = mbtiType;
      });

      String first = _selectedMbti1!;
      String second = _selectedMbti2!;

      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _selectedMbti1 = null;
          _selectedMbti2 = null;
        });

        showDialog(
            context: context,
            builder: (BuildContext context) {
              Map<String, List<String>> compatibility =
              mbtiCombinations[first]!;
              String relationship = '평범합니다.';

              if (compatibility['best']!.contains(second)) {
                relationship = "가장 좋습니다.";
              } else if (compatibility['good']!.contains(second)) {
                relationship = "Good";
              } else if (compatibility['bad']!.contains(second)) {
                relationship = "Bad";
              }
              return AlertDialog(
                title: Text('Compatibility: $relationship'),
                content: Text(
                    'MBTI 궁합 결과 $first와 $second 의 궁합은 $relationship.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            });
      });
    }
  }
}