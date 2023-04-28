
class RunningAverageFilter{
  private:
    int numReadings = 10;
    float readings[10];
    float total;
    float average;
    int readIndex;


    void calcAverage(int latest_reading){
      total = total - readings[readIndex];
      readings[readIndex] = latest_reading;
      total = total + readings[readIndex];
      readIndex++;

      if (readIndex >= numReadings) {
        readIndex = 0;
      }
      average = total / numReadings;
      delay(1); 
    }

  public: 
    RunningAverageFilter(){
      total = 0;
      average = 0;
      readIndex = 0;
    }

    float getAverage(int latest_reading){
      calcAverage(latest_reading);
      return average;
    }

};