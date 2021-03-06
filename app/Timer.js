const pad = v => (v > 9 ? v : `0${v}`);

import BackgroundTimer from "react-native-background-timer";
export class Timer {
  hours = 0;
  minutes = 0;
  seconds = 0;
  millseconds = 0;
  static instance = new Timer();
  static timer = null;
  static runner(handler) {
    //定义计时函数
    Timer.instance.millseconds += 50; //毫秒
    if (Timer.instance.millseconds >= 1000) {
      Timer.instance.millseconds = 0;
      Timer.instance.seconds += 1; //秒
    }
    if (Timer.instance.seconds >= 60) {
      Timer.instance.seconds = 0;
      Timer.instance.minutes += 1; //分钟
    }
    if (Timer.instance.minutes >= 60) {
      Timer.instance.minutes = 0;
      Timer.instance.hours += 1;
    }
    const { hours, minutes, seconds } = Timer.instance;
    let display = `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
    handler(display);
  }
  static start=(handler) => Timer.timer = BackgroundTimer.setInterval(() => Timer.runner(handler), 50);
  static pause=()=>    BackgroundTimer.clearInterval(Timer.timer);
  static stop() {
    BackgroundTimer.clearInterval(Timer.timer);
    Timer.timer = null;
  }
}
