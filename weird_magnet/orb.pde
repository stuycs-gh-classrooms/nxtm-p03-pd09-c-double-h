class Orb
{

  //instance variables
  PVector center;
  PVector velocity;
  PVector acceleration;
  float bsize;
  float mass;
  color c;
  int charge;


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS CONSTRUCTOR DOES
   and/or
   WHY IT EXISTS
   */
  Orb()
  {
    bsize = random(10, MAX_SIZE);
    float x = random(bsize/2, width-bsize/2);
    float y = random(bsize/2, height-bsize/2);
    center = new PVector(x, y);
    mass = random(10, 100);
    velocity = new PVector();
    acceleration = new PVector();
    if (random(2) > 1) {
      charge = 1;
    } else {
      charge = -1;
    }
    setColor();
  }


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS CONSTRUCTOR DOES
   and/or
   WHY IT EXISTS
   */
  Orb(float x, float y, float s, float m)
  {
    bsize = s;
    mass = m;
    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    if (random(2) > 1) {
      charge = 1;
    } else {
      charge = -1;
    }
    setColor();
  }


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  void move(boolean bounce)
  {
    if (bounce) {
      xBounce();
      yBounce();
    }

    velocity.add(acceleration);
    center.add(velocity);
    acceleration.mult(0);
  }//move


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  void applyForce(PVector force)
  {
    PVector scaleForce = force.copy();
    scaleForce.div(mass);
    acceleration.add(scaleForce);
  }


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  PVector getDragForce(float cd)
  {
    float dragMag = velocity.mag();
    dragMag = -0.5 * dragMag * dragMag * cd;
    PVector dragForce = velocity.copy();
    dragForce.normalize();
    dragForce.mult(dragMag);
    return dragForce;
  }


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  PVector getGravity(Orb other, float G)
  {
    float strength = G * mass*other.mass;
    //dont want to divide by 0!
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    return force;
  }

  /**
   getSpring()
   
   This should calculate the force felt on the calling object by
   a spring between the calling object and other.
   
   The resulting force should pull the calling object towards
   other if the spring is extended past springLength and should
   push the calling object away from o if the spring is compressed
   to be less than springLength.
   
   F = kx (ABhat)
   k: Spring constant
   x: displacement, the difference of the distance
   between A and B and the length of the spring.
   (ABhat): The normalized vector from A to B
   */
  PVector getSpring(Orb other, int springLength, float springK)
  {
    PVector direction = PVector.sub(other.center, center);

    float displacement = center.dist(other.center) - springLength;
    float mag = springK * displacement;
    direction.mult(mag);

    return direction;
  }//getSpring
  
  PVector getMagnet(Orb other, int charge, float magField){
    PVector magForce = velocity.mult(charge * magField);
    if (this.charge == other.charge ){
      magForce.mult(-1);
    }//same charges (++ or --)
    return magForce;
  }//getMagnet


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  boolean yBounce()
  {
    if (center.y > height - bsize/2) {
      velocity.y *= -1;
      center.y = height - bsize/2;

      return true;
    }//bottom bounce
    else if (center.y < bsize/2) {
      velocity.y*= -1;
      center.y = bsize/2;
      return true;
    }
    return false;
  }//yBounce


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  boolean xBounce()
  {
    if (center.x > width - bsize/2) {
      center.x = width - bsize/2;
      velocity.x *= -1;
      return true;
    } else if (center.x < bsize/2) {
      center.x = bsize/2;
      velocity.x *= -1;
      return true;
    }
    return false;
  }//xbounce


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  boolean collisionCheck(Orb other)
  {
    return ( this.center.dist(other.center)
      <= (this.bsize/2 + other.bsize/2) );
  }//collisionCheck


  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  void setColor()
  {
    color c0;
    if (charge >= 0) {
      c0 = color(255, 0, 0);
    }
    else {
      c0 = color(0, 255, 255);
    }
    color c1 = color(0);
    /*
    YOUR CONCISE EXPLANATION IN COLLOQUIAL ENGLISH
     OF WHAT THIS PROCESSING BUILT-IN DOES...
     */
    c = c0;
    //lerpColor(c0, c1, (mass-MIN_SIZE)/(MAX_MASS-MIN_SIZE));
  }//setColor


  //visual behavior
  void display()
  {
    noStroke();
    fill(c);
    circle(center.x, center.y, bsize);
    fill(0);
    String cSymbol;
    if (charge > 0) {
      cSymbol = "+";
    }
    else {
      cSymbol = "-";
    }
    text(cSymbol, center.x, center.y);
  }//display
}//Ball
