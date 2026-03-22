[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/OwTRjgv_)
## Project 00
### NeXTCS
### Period: 09
## Thinker0: Crystal
## Thinker1: Hugo
## Thinker2: Haley
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Magnetic Force

### Custom Force Formula
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

F = qvB

F = Magnetic force
q = charge
v = Velocity of the charge
B = Magnetic field (constant)

### Custom Force Breakdown
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - Velocity

- Does this force require any new constants, if so what are they and what values will you try initially?
  - It requires a Magnetic field constant and we could try constants that are a bit bigger than getGravity's constant
  - Charge is also a constant but the sign matters 

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - Charge and Magnetic field
  - Magnetic field is a PVector
  - Charge is a float

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - Yes, opposites attract. alike repel

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - No because we are already given a velocity from the orbs class and are assigning the magnetic field as a constant. q would be one of two constants depending on charge.

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

Use Newton's law to find gravity between two objects and add velocity to them

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

Create springs between the orbs that can compress and decompress for movement

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

There will be a drag each orb interacts with that goes in the opposing motion

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

The orbs will repel or attract to each other and to the fixed orb depending on if they represent a north or south pole

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

