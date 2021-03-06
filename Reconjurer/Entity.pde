private static ArrayList<PImage> LOADED_IMAGES = new ArrayList();
private static ArrayList<String> LOADED_NAMES = new ArrayList();
private static int LOADED_COUNTER = 0;

public static int directionalComplement(float angle, int direction) {
    angle = abs(angle);
    
    if (0 <= angle && angle < QUARTER_PI || TWO_PI - QUARTER_PI < angle && angle <= TWO_PI)
        return 0 < direction ? 2 : 3; // right, left
    
    if (QUARTER_PI < angle && angle < PI - QUARTER_PI)
        return 0 < direction ? 1 : 0; // down, up
    
    if (PI - QUARTER_PI < angle && angle < PI + QUARTER_PI)
        return 0 < direction ? 3 : 2; // left, right
    
    if (PI + QUARTER_PI < angle && angle < TWO_PI - QUARTER_PI)
        return 0 < direction ? 0 : 1; // up, down
    
    return -1;
}

public class Entity {
    
    protected PImage image;
    
    protected float hitbox;
    protected boolean isDead;

    public Entity(String imageFileName, float hitboxSize) {
        this.image = this.getImage(imageFileName);
        
        this.hitbox = hitboxSize;
        this.isDead = false;
    }
    
    public PImage getImage(String name) {
        int k;
        for (k = 0; k < Reconjurer.LOADED_COUNTER; k++)
            if (Reconjurer.LOADED_NAMES.get(k) == name)
                break;
        
        if (k == Reconjurer.LOADED_COUNTER) {
            Reconjurer.LOADED_IMAGES.add(loadImage("images/" + name + ".png"));
            Reconjurer.LOADED_NAMES.add(name);
            Reconjurer.LOADED_COUNTER++;
        }
        
        return Reconjurer.LOADED_IMAGES.get(k);
    }
    
    public void show(Reconjurer app) {
        if (this.image != null) {
            app.pushMatrix();
            
            app.scale(this.hitbox / this.image.width, this.hitbox / this.image.height);
            app.translate(-this.image.width / 2f, -this.image.height / 2f);
            
            app.image(this.image, 0, 0);
            
            app.popMatrix();
        }
    }
    
    public float getHitbox() {
        return this.hitbox;
    }
    
    public boolean isDead() {
        return this.isDead;
    }
    
    public void kill() {
        this.isDead = true;
    }
    
}
