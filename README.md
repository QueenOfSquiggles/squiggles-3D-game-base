# squiggles-game-base
 A base for my 3D First Person games, always improving
 
 ## Notes for structure:
 
 ### Hierarchy
 res:
  - Modules
  - Boilerplate
  - GameDefinitions
 
### Modules

Every subfolder in this section should be a completely contained module. It should serve a single purpose and solve a single problem. Ideally any necessary assets would also be contained in this module as well. No external dependencies. This is a constraint because I want these modules to be able to be dropped directly into any other project and work as expected.
 
### Boilerplate

Boilerplate is for code that will likely be shared between projects, but doesn't fit the constraints of the modules. Ideally, this section should be kept as lean as absolutely possible. 
 
### GameDefinitions

All code and definitions that are specific to the game project being made. At regular intervals, this code should be refactored and possibly have chunks moved into the Modules category.

For a new game project, this folder may not even exist because it does no contain any files. 

# Addons

There are several addons installed as well for several functions. Where possible, their README and LICENSE files are in the individual addon folders.

# Use

This project is under the MIT license. I will personally be developing this tailored to my needs as an individual developer, however, I am making it publicly available in case it serves as a benefit to anyone.
