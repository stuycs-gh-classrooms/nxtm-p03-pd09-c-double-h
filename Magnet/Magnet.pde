/** -----------------------------------------------
 SpringArrayDriver (Most Work Goes Here)
 
 TASK:
 You will write a program that creates an array of orbs.
 When run, the simulation should show the orbs,
 connected by springs,
 moving according to the push/pull of the spring forces.
 
 Earth gravity will be a toggle-able option,
 as well as whether the simulation is running movement or not.
 
 Part 0: Create and populate the array of orbs.
 
 Part 1: Draw the "springs" connecting the orbs.
 
 Part 2: Calculate and apply the spring force to the
 orbs in the array.
 Part 3: Apply earth based gravity and drag if those
 options are turned on.
 
 Part 4: Allow for the removal and addition of orbs
 
 CONCURRENT TASK:
 As you go, or just before you submit,
 Fill in the placeholder comment zones with YOUR OWN WORDS.
 ----------------------------------------------- */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;

int MAGNET = 4;
float MAG_K = 4.0;
float REP_K = 1;

boolean[] toggles = new boolean[5];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Magnetic"};

FixedOrb earth;
Orb[] orbs;
int orbCount;


void setup()
{
  size(600, 600);

  //Part 0: Write makeOrbs below
  makeOrbs(true);
  //Part 3: create earth to simulate gravity
  earth = new FixedOrb(width/2, 150, 100, 50);
  earth.charge = 1;
}//setup


void draw()
{
  background(255);
  displayMode();
  earth.display();

  //draw the orbs and springs
  for (int o=0; o < orbCount; o++) {
    orbs[o].display();
    if (o < orbCount - 1) {
      drawSpring(orbs[o], orbs[o + 1]);
    }
    //Part 1: write drawSpring below
    //Use drawspring correctly to draw springs
  }//draw orbs & springs

  if (toggles[MOVING]) {
    //Part 2: write applySprings below
    applySprings();

    //part 3: apply other forces if toggled on
    for (int o=0; o < orbCount; o++) {
      if (toggles[GRAVITY]) {
        orbs[o].applyForce(orbs[o].getGravity(earth, G_CONSTANT));
      }
      if (toggles[DRAGF]) {
        orbs[o].applyForce(orbs[o].getDragForce(D_COEF));
      }
      if (toggles[MAGNET]) {
        for (int i = 0; i < orbCount; i++) {
          for (int j = 0; j < orbCount; j++) {

            if (i != j) {
              PVector f = orbs[i].getMagneticForce(orbs[j], MAG_K);
              orbs[i].applyForce(f);
            }
            // prevents orb overlap
            PVector repel = orbs[i].getRepulsion(orbs[j], REP_K);
            orbs[i].applyForce(repel);
          }
        }
      }
    }//gravity, drag, magnet

    for (int o=0; o < orbCount; o++) {
      orbs[o].move(toggles[BOUNCE]);
    }
  }//moving
}//draw


/**
 makeOrbs(boolean ordered)
 
 Set orbCount to NUM_ORBS
 Initialize and create orbCount Orbs in orbs.
 All orbs should have random mass and size.
 The first orb should be a FixedOrb
 If ordered is true:
 The orbs should be spaced SPRING_LENGTH distance
 apart along the middle of the screen.
 If ordered is false:
 The orbs should be positioned radomly.
 
 Each orb will be "connected" to its neighbors in the array.
 */
void makeOrbs(boolean ordered)
{
  orbCount = NUM_ORBS;
  orbs = new Orb[orbCount];

  for (int i = 0; i < orbs.length; i ++) {
    float s = random(MIN_SIZE, MAX_SIZE);
    float m = random(MIN_MASS, MAX_MASS);
    int x = SPRING_LENGTH * (i + 1);
    int y = height/2;
    if (i == 0) {
      fill(#EA899A);
      // earth = new FixedOrb(x, y, s, m);
      // orbs[i] = earth;
      orbs[i] = new FixedOrb(x, y, s, m);
      orbs[i].charge = 1;
    } else {
      if (ordered) {
        orbs[i] = new Orb(x, y, s, m);
      } else {
        orbs[i] = new Orb();
      }
    }
  }
}//makeOrbs


/**
 drawSpring(Orb o0, Orb o1)
 
 Draw a line between the two Orbs.
 Line color should change as follows:
 red: The spring is stretched.
 green: The spring is compressed.
 black: The spring is at its normal length
 */
void drawSpring(Orb o0, Orb o1)
{
  float distance = o0.center.dist(o1.center);
  if (distance > SPRING_LENGTH) {
    stroke(255, 0, 0);
  } else if (distance == SPRING_LENGTH) {
    stroke(0);
  } else {
    stroke(0, 255, 0);
  }
  line(o0.center.x, o0.center.y, o1.center.x, o1.center.y);
}//drawSpring


/**
 applySprings()
 
 FIRST: Fill in getSpring in the Orb class.
 
 THEN:
 Go through the Orbs array and apply the spring
 force correctly for each orb. We will consider every
 orb as being "connected" via a spring to is
 neighboring orbs in the array.
 */
void applySprings()
{
  PVector f = new PVector();

  for (int i = 0; i < orbCount; i++) {
    if (i - 1 > -1) {
      f = orbs[i].getSpring(orbs[i-1], SPRING_LENGTH, SPRING_K);
      orbs[i].applyForce(f);
    }
    if (i + 1 < orbCount) {
      f = orbs[i].getSpring(orbs[i+1], SPRING_LENGTH, SPRING_K);
      orbs[i].applyForce(f);
    }
  }
}//applySprings


/**
 addOrb()
 
 Add an orb to the arry of orbs.
 
 If the array of orbs is full, make a
 new, larger array that contains all
 the current orbs and the new one.
 (check out arrayCopy() to help)
 */
void addOrb()
{
  if (orbCount < orbs.length) {
    orbs[orbCount] = new Orb();
    orbCount++;
  } else {
    Orb[] newOrbs = new Orb[orbs.length + 1];
    for (int i = 0; i < orbs.length; i++) {
      newOrbs[i] = orbs[i];
    }
    newOrbs[orbCount] = new Orb();
    orbs = newOrbs;
    orbCount++;
  }
}//addOrb

void removeOrb()
{
}

/**
 keyPressed()
 
 Toggle the various modes on and off
 Use 1 and 2 to setup model.
 Use - and + to add/remove orbs.
 */
void keyPressed()
{
  if (key == ' ') {
    toggles[MOVING]  = !toggles[MOVING];
  }
  if (key == 'g') {
    toggles[GRAVITY] = !toggles[GRAVITY];
  }
  if (key == 'b') {
    toggles[BOUNCE]  = !toggles[BOUNCE];
  }
  if (key == 'd') {
    toggles[DRAGF]   = !toggles[DRAGF];
  }
  if (key == 'm') {
    toggles[MAGNET] = !toggles[MAGNET];
  }

  if (key == 'e') {
    earth.charge *= -1;
    if (earth.charge == -1) {
      earth.c = color(0, 255, 255);
    } else if (earth.charge == 1) {
      earth.c = color(255, 0, 0);
    }
  }
  if (key == '1') {
    makeOrbs(true);
  }
  if (key == '2') {
    makeOrbs(false);
  }

  if (key == '-') {
    //Part 4: Write code to remove an orb from the array
    orbCount--;
  }//removal
  if (key == '=' || key == '+') {
    //Part 4: Write addOrb() below
    addOrb();
  }//addition
}//keyPressed



void displayMode()
{
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
