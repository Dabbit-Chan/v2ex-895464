import 'dart:io';

void main() {

  List<double> resultList = [62.13, 26.67, 17.76];
  List<double> targetList = [24.92,5.88,5.04,3.64,3.45,3.36,2.8,2.8,2.52,2.24,2.24,2.24,1.96,1.96,1.8,1.68,1.4,1.4,1.4,1.2,1.2,1.15,1.12,1.12,1.12,1.12,1.12,0.84,0.84,0.84,0.84,0.84,0.84,0.84,0.84,0.84,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.56,0.4,0.4,0.4,0.4,0.4,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28,0.28];

  // List<double> resultList = [52.7,8.96];
  // List<double> targetList = [21.44,6.72,5.44,5.12,4.48,3.20,2.24,1.92,1.92,1.92,1.28,1.28,1.00,0.96,0.50,0.32,0.32,0.32,0.32,0.32,0.32,0.32];

  List<int> intResultList = [];
  List<int> intTargetList = [];

  for (double i in resultList) {
    intResultList.add((i * 100).round());
  }

  for (double i in targetList) {
    intTargetList.add((i * 100).round());
  }

  if (intResultList.reduce((v, e) => v + e) != intTargetList.reduce((v, e) => v + e)) {
    print('no answer');
    exit(0);
  }

  intResultList.sort();
  intTargetList.sort();

  void println(List<int> bused) {
    print('***************************');
    for (int i = 0; i < intResultList.length; i++) {
      stdout.write('${intResultList[i] / 100}: ');
      List<double> outList = [];
      for (int j = 0; j < intTargetList.length; j++) {
        if (bused[j] == i) {
          outList.add(intTargetList[j] / 100);
        }
      }
      print(outList);
      print('***************************');
    }
  }

  void calc(List<int> bused, int s, int index, int begin) {
    for (int i = begin; i < intTargetList.length; i++) {
      if (bused[i] > 0) {
        continue;
      }
      if (i > 0 && intTargetList[i - 1] == intTargetList[i] && bused[i - 1] == 0) {
        continue;
      }
      if (intTargetList[i] > s) {
        break;
      } else {
        bused[i] = index;
        if (intTargetList[i] < s) {
          calc(bused, s - intTargetList[i], index, i + 1);
        } else if (index + 1 < intResultList.length) {
          calc(bused, intResultList[index + 1], index + 1, 0);
        } else {
          println(bused);
          exit(0);
        }
        bused[i] = 0;
      }
    }
  }

  List<int> newList = List.generate(intTargetList.length, (_) => 0);
  calc(newList, intResultList[1], 1, 0);
}

