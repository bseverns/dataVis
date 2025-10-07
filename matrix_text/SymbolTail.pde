class SymbolTail {
    int x, y;
    int cont;
    int speed = (int) random(3, 6);
    int life;
    char chr;
    boolean alive;
 
    SymbolTail(int xini, int yini, int lifeini, char chrini) {
        x = xini;
        y = yini;
        life = lifeini;
        cont = 0;
        chr  = chrini;
        alive = true;
    }
 
    void draw() {
        if ((int) random(0, 50) == 0 && cont > 10) {
            chr = getRandomChar();
        }
 
        fill(0, life*20, 0);
        text(chr, x * gridsize, y * gridsize);
        cont++;
 
        if (cont%speed == 0) {
            life--;
            if (life <= 0) alive = false;
        }
    }
}