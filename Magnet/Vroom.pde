class FixedOrb extends Orb
{

  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  FixedOrb(float x, float y, float s, float m)
  {
    super(x, y, s, m);
    if (charge == -1){
     c = color(0, 255, 255);
   
    }
    
    else if (charge == 1){
       c = color(255, 0, 0);
    }
  }

  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  FixedOrb()
  {
    super();
    c = color(255, 0, 0);
   
  }

  /**
   YOUR CONCISE+CLEAR DESCRIPTION OF WHAT THIS METHOD DOES
   and/or
   WHY IT EXISTS
   */
  void move(boolean bounce)
  {
    //do nothing
  }
}//fixedOrb
