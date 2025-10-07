HashMap<Integer, Integer> hashMap = new HashMap<Integer, Integer>();

int minKey = 0;
int maxKey = 200;

Random r = new Random();

void setup() {
  size(200,500);
  frameRate(240);
}

void draw() {

    for(int i = 0; i < 100; i++) {
      pickNumber();
    }
  
   for(int i = minKey; i < maxKey; i++) {
    if(hashMap.containsKey(i)) {
      int cnt = hashMap.get(i);
      stroke(0);
      line(i, height, i, height-cnt);
      //println(i + " " + cnt);
    }
  } 
}

void pickNumber() {
  background(255);
  int count = 0;
  int myNewNumber = (int)(r.nextGaussian()*maxKey);
  //int(random(minKey, maxKey));
  if( hashMap.containsKey(new Integer(myNewNumber))) {
    count = hashMap.get(myNewNumber);
    count++;
  }
  hashMap.put(myNewNumber, count);



}

