class SymbolHead {
    int x, y;
    int cont;
    int speed = (int) random(3, 6);
    char chr;
    boolean alive;
    ArrayList tail = new ArrayList();
 
    SymbolHead(int xini, int yini) {
        x = xini;
        y = yini;
        chr = getRandomChar();
        cont = 0;
        alive = true;
    }
 
    void draw() {
        int rnd = (int) random(170, 255);
        fill(rnd, 255, rnd);
        text(chr, x * gridsize, y * gridsize);
        cont++;
 
        if (cont%speed == 0) {
            if ((int) random(5) != 0) {
                tail.add(new SymbolTail(x, y, (int) random(10, 20), chr));
                chr = getRandomChar();
                y++;
            }
 
            if (y > height/gridsize + 40) {
                alive = false;
                tail.clear();
            }
        }
 
        for (int i = 0; i < tail.size(); i++) {
            SymbolTail cauda = (SymbolTail) tail.get(i);
            cauda.draw();
 
            if (cauda.alive == false) tail.remove(i);
        }
    }
}