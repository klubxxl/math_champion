import 'dart:math';

class GameEngine {
  int actualRound = -1;
  // DATA TO EASY GAME
  List<int> roundsDurationEasy = [
    5000,
    4000,
    3000,
    2500,
    5000,
    4000,
    3000,
    5000,
    3000,
  ];
  List<int> resultRangeEasy = [
    100,
    100,
    100,
    100,
    400,
    400,
    400,
    900,
    900,
  ];
  // DATA TO HARD GAME
  List<int> roundsDurationHard = [
    3000,
    2000,
    3000,
    2400,
    4000,
    3000,
    5000,
    3000,
    2000,
  ];
  List<int> resultRangeHard = [
    100,
    100,
    400,
    400,
    1000,
    1000,
    10000,
    10000,
    10000,
  ];

  Map<String, Object> getGameData(bool? hardMode) {
    bool isHard = hardMode ?? false;
    actualRound++;

    // const round and duration
    int round = actualRound;
    int lvl = getLevel(round);
    int duration = isHard ? roundsDurationHard[lvl] : roundsDurationEasy[lvl];
    // random sign
    int signType = Random().nextInt(4);
    String sign = '';
    switch (signType) {
      case 0:
        sign = '+';
        break;
      case 1:
        sign = '-';
        break;
      case 2:
        sign = '*';
        break;
      case 3:
        sign = ':';
        break;
    }
    // random values
    int maxResultRange = isHard
        ? resultRangeHard[lvl]
        : resultRangeEasy[lvl]; // max result from 0 to x
    int value1 = 0, value2 = 0;
    int result = 0;
    switch (sign) {
      case '+':
        int maxVal = ((maxResultRange / 2) + 1).floor();
        int val1 = Random().nextInt(maxVal);
        int val2 = Random().nextInt(maxVal);
        value1 = val1;
        value2 = val2;
        result = val1 + val2;
        break;
      case '-':
        int maxVal = ((maxResultRange / 2) + 1).floor();
        int val1 = Random().nextInt(maxVal);
        int val2 = Random().nextInt(maxVal);
        value1 = val2 + val1;
        value2 = val1 > val2 ? val1 : val2;
        result = val1 > val2 ? val2 : val1;
        break;
      case '*':
        int maxVal = sqrt(maxResultRange).floor();
        int val1 = Random().nextInt(maxVal);
        int val2 = Random().nextInt(maxVal);
        value1 = val1;
        value2 = val2;
        result = val1 * val2;
        break;
      case ':':
        int maxVal = sqrt(maxResultRange).floor();
        int val1 = Random().nextInt(maxVal - 1) + 1;
        int val2 = Random().nextInt(maxVal);
        value1 = val2 * val1;
        value2 = val1 > val2 ? val1 : val2;
        result = val1 > val2 ? val2 : val1;
        break;
    }
    // generating array with one correct and 3 wrong answers
    List<int> answ =
        getWrongAnswers(value1, value2, result, maxResultRange, sign);
    answ.add(result);
    int indexOfAnswer = Random().nextInt(4);
    if (indexOfAnswer != 3) {
      int helper = answ[indexOfAnswer];
      answ[indexOfAnswer] = result;
      answ[3] = helper;
    }
    // return map with data
    return {
      'round': round,
      'duration': duration,
      'task': '$value1 $sign $value2',
      'answer0': answ[0],
      'answer1': answ[1],
      'answer2': answ[2],
      'answer3': answ[3],
      'correctIndex': indexOfAnswer,
    };
  }

  int getLevel(int round) {
    if (round < 3)
      return 0;
    else if (round < 6)
      return 1;
    else if (round < 10)
      return 2;
    else if (round < 15)
      return 3;
    else if (round < 20)
      return 4;
    else if (round < 30)
      return 5;
    else if (round < 40)
      return 6;
    else if (round < 50)
      return 7;
    else
      return 8;
  }

  int _getWrongAnswer(int val1, int val2, int result, int maxRes, String sign) {
    int typeOfPickingWrongAnsw = Random().nextInt(10);
    if (typeOfPickingWrongAnsw < 3) {
      return result + 1;
    } else if (typeOfPickingWrongAnsw < 5) {
      return result - 1;
    } else if (typeOfPickingWrongAnsw < 7) {
      switch (sign) {
        case '+':
          return result + Random().nextInt(5) - 2;
        case '-':
          return result + Random().nextInt(5) - 2;
        case '*':
          return (val1 + 1) * val2;
        case ':':
          return result + Random().nextInt(5) - 2;
      }
    } else if (typeOfPickingWrongAnsw < 9) {
      switch (sign) {
        case '+':
          return result + (Random().nextInt(4) * 10) - 10;
        case '-':
          return result + (Random().nextInt(4) * 10) - 10;
        case '*':
          return (val1 - 1) * val2;
        case ':':
          return result + (Random().nextInt(4) * 10) - 10;
      }
    }
    return Random().nextInt(maxRes);
  }

  List<int> getWrongAnswers(
      int val1, int val2, int result, int maxRes, String sign) {
    int ans1, ans2, ans3;
    ans1 = _getWrongAnswer(val1, val2, result, maxRes, sign);
    while (ans1 == result || ans1 < 0) {
      ans1++;
    }
    ans2 = _getWrongAnswer(val1, val2, result, maxRes, sign);
    while (ans2 == result || ans2 == ans1 || ans2 < 0) {
      ans2++;
    }
    ans3 = _getWrongAnswer(val1, val2, result, maxRes, sign);
    while (ans3 == result || ans3 == ans1 || ans3 == ans2 || ans3 < 0) {
      ans3++;
    }

    return [ans3, ans1, ans2];
  }
}

    // if (actualRound < 2) {
    //   return _level0();
    // } else if (actualRound < 4) {
    //   return _level1();
    // } else if (actualRound < 5) {
    //   return _level2();
    // } else if (actualRound < 10) {
    //   return _level3();
    // } else if (actualRound < 15) {
    //   return _level4();
    // } else if (actualRound < 20) {
    //   return _level5();
    // } else if (actualRound < 30) {
    //   return _level6();
    // } else if (actualRound < 40) {
    //   return _level7();
    // } else if (actualRound < 50) {
    //   return _level8();
    // } else {
    //   return _level9();
    // }

  // Map<String, Object> _level0() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 3000;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 100; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level1() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 2200;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 100; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2 =',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level2() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 1400;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 100; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level3() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 3000;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 200; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level4() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 2000;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 200; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level5() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 1400;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 200; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level6() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 3000;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 1000; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level7() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 2200;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 1000; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level8() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 1600;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 1000; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

  // Map<String, Object> _level9() {
  //   // const round and duration
  //   int round = actualRound;
  //   int duration = 1600;
  //   // random sign
  //   int signType = Random().nextInt(4);
  //   String sign = '';
  //   switch (signType) {
  //     case 0:
  //       sign = '+';
  //       break;
  //     case 1:
  //       sign = '-';
  //       break;
  //     case 2:
  //       sign = '*';
  //       break;
  //     case 3:
  //       sign = ':';
  //       break;
  //   }
  //   // random values
  //   int maxResultRange = 10000; // max result from 0 to x
  //   int value1 = 0, value2 = 0;
  //   int result = 0;
  //   switch (sign) {
  //     case '+':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 + val2;
  //       break;
  //     case '-':
  //       int maxVal = ((maxResultRange / 2) + 1).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 + val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //     case '*':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal);
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val1;
  //       value2 = val2;
  //       result = val1 * val2;
  //       break;
  //     case ':':
  //       int maxVal = sqrt(maxResultRange).floor();
  //       int val1 = Random().nextInt(maxVal - 1) + 1;
  //       int val2 = Random().nextInt(maxVal);
  //       value1 = val2 * val1;
  //       value2 = val1 > val2 ? val1 : val2;
  //       result = val1 > val2 ? val2 : val1;
  //       break;
  //   }
  //   // generating array with one correct and 3 wrong answers
  //   List<int> answ =
  //       getWrongAnswers(value1, value2, result, maxResultRange, sign);
  //   answ.add(result);
  //   int indexOfAnswer = Random().nextInt(4);
  //   if (indexOfAnswer != 3) {
  //     int helper = answ[indexOfAnswer];
  //     answ[indexOfAnswer] = result;
  //     answ[3] = helper;
  //   }
  //   // return map with data
  //   return {
  //     'round': round,
  //     'duration': duration,
  //     'task': '$value1 $sign $value2',
  //     'answer0': answ[0],
  //     'answer1': answ[1],
  //     'answer2': answ[2],
  //     'answer3': answ[3],
  //     'correctIndex': indexOfAnswer,
  //   };
  // }

