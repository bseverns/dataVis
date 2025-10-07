import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hermes.*; 
import hermes.hshape.*; 
import hermes.animation.*; 
import hermes.physics.*; 
import hermes.postoffice.*; 
import java.util.Random; 
import static hermes.HermesMath.*; 
import static hermes.postoffice.POCodes.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class bouncingpolygonsdemo extends PApplet {

/*
* Physics demo:
* Click and release mouse to create shapes
* Drag to give polygon velocity
* Use the '1', '2', and '3' keys to choose shape
* '1' = HRectangle, '2' = HCircle, '3' = HPolygon
* Use the 'd' key to delete shapes
*
* OSC demo:
* Open 'oscControl.pd' in puredata
* Click the button attached to the 'connect' message
* While this sketch is running,
* use sliders to create polygons of different shapes and sizes
*/

//import src.template.library.*;









//////////////
// Constants
//////////////

//Engine parts
World _world;
PostOffice _postOffice;
HCamera _camera;

//Groups
BallGroup _ballGroup;
BoxGroup _boxGroup;

//Tracking the mouse
boolean _mousePressed;
float _origX, _origY;
float _dX, _dY;

//Screen/World size
final int WIDTH = 400;
final int HEIGHT = 400;

//Used in creating polygons, updated by OSC
static int polyPoint = 3; //Number of points in PolyBalls
static float polyRot = 0; //Amount to rotate new PolyBalls by

//Constant determining ball size
static final int ballSize = 25; //Size of ball, scaled by ball mass

//Used for creating different shapes
static int mode = 0; //Mode dictating which type of ball will get created
static final int POLY_MODE = 0;
static final int POLY_KEY = Key.VK_1;
static final int CIRCLE_MODE = 1;
static final int CIRCLE_KEY = Key.VK_2;
static final int RECT_MODE = 2;
static final int RECT_KEY = Key.VK_3;
static final int DELETE_KEY = Key.D;

// instructions
String instruct = "Click and drag!";

public void setup() {
  size(WIDTH, HEIGHT);
  Hermes.setPApplet(this);
 
  //Set up the engine
  _camera = new HCamera();
  try {
    _postOffice = new PostOffice(8080, 8000);
  } catch(Exception e) {
    _postOffice = new PostOffice();
  }
  _world = new DemoWorld(_postOffice, _camera);
  _world.lockUpdateRate(50);

  smooth();

  _world.start(); // gets the World thread running
}


public void draw() {
  background(230); //Overwrite what's already been drawn
  
  if(_mousePressed) {
    //Draw line indicating velocity of created ball
    line(_origX, _origY, _dX, _dY);
  }
    
  _camera.draw(); //Camera object handles drawing all the appropriate Beings
  
  // draw instructions
  fill(0);
  text(instruct, 10, 20);

}
/**
 * Holds and keeps track of balls
 * Handles messages and the creation of new balls
 */
class BallGroup extends Group<Ball> {
  
  //Used in creating balls, updated via OSC
  float _newMass = 1;
  float _newElasticity = 1;
  
  BallGroup(World world) {
   super(world); 
   _mousePressed = false;
  }

  //Updates ball creation mode depending on key press
	public void receive(KeyMessage m) {
		int key = m.getKeyCode();
		switch(key) {
			case POLY_KEY:
				mode = POLY_MODE;
				break;
			case CIRCLE_KEY:
				mode = CIRCLE_MODE;
				break;
			case RECT_KEY:
				mode = RECT_MODE;
				break;
			case DELETE_KEY:
				destroy();
				break;
		}
	}

  //Handles mouse messages for line drawing and ball creation
	public void receive(MouseMessage m) {
		POCodes.Click action = m.getAction();
		switch(action) {
			case PRESSED: //Register mouse press and initialize variables
				if(!_mousePressed) {
					_mousePressed = true;
					_origX = m.getX();
					_origY = m.getY();
					_dX = m.getX();
					_dY = m.getY();
				}
				break;
			case DRAGGED: //Update mouse location
				_dX = m.getX();
				_dY = m.getY();
				break;
			case RELEASED: //Deregister mouse press and create new ball
				_mousePressed = false;
				Ball ball;
				switch(mode) {
					case POLY_MODE:
						ball = new PolyBall(new PVector(_origX, _origY), new PVector(_origX-_dX, _origY-_dY), _newMass, _newElasticity);
						break;
					case CIRCLE_MODE:
						ball = new HCircleBall(new PVector(_origX, _origY), new PVector(_origX-_dX, _origY-_dY), _newMass, _newElasticity);
						break;
					case RECT_MODE:
						ball = new RectBall(new PVector(_origX, _origY), new PVector(_origX-_dX, _origY-_dY), _newMass, _newElasticity);
						break;
					default:
						System.out.println("In an invalid mode");
						ball = new HCircleBall(new PVector(_origX, _origY), new PVector(_origX-_dX, _origY-_dY), _newMass, _newElasticity);
						break;
				}
				getWorld().register(ball);
				this.add(ball);
				break;
		}
	}
  
  //Updates variables influencing ball creation
	public void receive(OscMessage m) {
		String[] messages = m.getAddress().split("/");
		if(messages[1].equals("BouncingBalls")) {
			if(messages[2].equals("SetMass")) {
				_newMass = constrain(m.getAndRemoveFloat(), 0, 1);
			}
			else if(messages[2].equals("SetElasticity")) {
				_newElasticity = constrain(m.getAndRemoveFloat(), 0, 1);
			}
			else if(messages[2].equals("SetSides")) {
				polyPoint = (int) m.getAndRemoveInt();
			}
			else if(messages[2].equals("SetRotate")) {
			  polyRot = constrain(m.getAndRemoveFloat(), 0, 2*PI);
			} 
    }
  }
}
/**
 * Abstract class for balls, contains basic functionality
 * Only difference between type of balls is the type of shape used
 */
abstract class Ball extends MassedBeing {
	
	Group _group;
  int _color;

	Ball(HShape shape, PVector velocity, float mass, float elasticity) {
		super(shape, velocity, mass, elasticity, 35, 8);
		_color = color(random(255), random(255), random(255));
	}
	
	public void update() {
    if(getX() < 0)
      setX(0);
    if(getY() < 0)
      setY(0);
    if(getX() > (float)WIDTH)
      setX((float)WIDTH);
    if(getY() > (float)HEIGHT)
      setY((float)HEIGHT);
  }

	public void draw() {
		fill(_color);
		getShape().draw();
	}
}

/**
 * Creates a polygonal ball
 * Uses factory method inside of HPolygon to create the polygons
 */
class PolyBall extends Ball {
  PolyBall(PVector center, PVector velocity, float mass, float elasticity) {
    super(HPolygon.createRegularHPolygon(center,polyPoint,ballSize * mass), velocity, mass, elasticity);
    ((HPolygon) getShape()).rotate(polyRot);
  }
}

/**
 * Creates a circular ball
 */
class HCircleBall extends Ball {
	HCircleBall(PVector center, PVector velocity, float mass, float elasticity) {
		super(new HCircle(center, ballSize * mass), velocity, mass, elasticity);
	}
}

/**
 * Creates a square ball
 */
class RectBall extends Ball {
	RectBall(PVector center, PVector velocity, float mass, float elasticity) {
		super(new HRectangle(center, ballSize * mass, ballSize * mass), velocity, mass, elasticity);
	}
}
/**
 * Container box to the world
 */
class Box extends MassedBeing {
  Box() {
   super(new HRectangle(new PVector(0,0), new PVector(0,0), new PVector((float)WIDTH,(float)HEIGHT)), new PVector(0,0), Float.POSITIVE_INFINITY, 1); 
  }
  
  public void draw() {}
}
/**
 * Represents the program frame
 * Keeps balls from escaping frame
 */
class BoxGroup extends Group<Box> {
  BoxGroup(World world) {
    super(world);
    Box boite = new Box();
      getWorld().register(boite);
    this.add(boite);
  }
}
class DemoWorld extends World {
  DemoWorld(PostOffice po, HCamera cam) {
    super(po, cam);
  }

  public void setup() {
    _ballGroup = new BallGroup(_world);
    //ball group handles all messages
    _postOffice.subscribe(_ballGroup, POLY_KEY);
    _postOffice.subscribe(_ballGroup, CIRCLE_KEY);
    _postOffice.subscribe(_ballGroup, RECT_KEY);
    _postOffice.subscribe(_ballGroup, DELETE_KEY);
    _postOffice.subscribe(_ballGroup, Button.LEFT);
    _postOffice.subscribe(_ballGroup, "/BouncingBalls/SetElasticity");
    _postOffice.subscribe(_ballGroup, "/BouncingBalls/SetMass");
    _postOffice.subscribe(_ballGroup, "/BouncingBalls/SetSides");
    _postOffice.subscribe(_ballGroup, "/BouncingBalls/SetRotate");

    _boxGroup = new BoxGroup(_world);

    //Set up the interactions
    _world.register(_ballGroup, _ballGroup, new MassedCollider(), new SelfInteractionOptimizer());
    _world.register(_boxGroup, _ballGroup, new InsideMassedCollider());
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "bouncingpolygonsdemo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
