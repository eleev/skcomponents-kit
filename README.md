# skcomponents-kit [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

[![Language](https://img.shields.io/badge/language-Swift-orange.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

**Last Update: 02/September/2018.**

# ✍️ About

This repository contains a collection of various `SpriteKit` nodes and components for intermediate/advanced use cases.

# ⚠️ Caution
- Please note that you have to be very careful if you are going to use the repo in commercial projects - **do not use** graphics assets. The assets were taken from the `Web` and [icons8.com](https://icons8.com). However **I strongly recommend to double check it**.

# 🕹 Joystick Node
Joystick node component. Controlls `movement` or/and `orientation` of attached node. Implemented using `POP` design. In order to use you need to conform to `Controllable2D` protocol composition typealias. Or you can conform to either `MovableProtocol` or `OrientationProtocol`. 

## Demo 
<img src="https://user-images.githubusercontent.com/5098753/43082767-809d26dc-8e9d-11e8-922e-474e8bf9f12c.gif" width="650">

# ⛓ Rope Node
Rope/Chain node component. Can also be used to simulate bridges, platforms and gameplay elemnts. 

## ToDo
- [ ] Ability to slice the rope into pieces

## Demo 
<img src="https://user-images.githubusercontent.com/5098753/38315832-0066c192-3832-11e8-8d20-d65daa1bf00b.gif" width="650">

# 💣 Destructible Node
Adds an ability to visualize explosions for `SKSpriteNode`s. The physics shape is recalculated when sprite is re-rendered. The effect is fairly simple, however it can be used for games like `Worms` in order to add more dynamic gameplay when using projectiles and bombs.

## ToDo
- [ ] Proper resizing - right now the texture is reset back to the original size when hit tested
- [ ] Ability to slice the node when it is sliced into more than one pieces

## Demo
<img src="https://user-images.githubusercontent.com/5098753/42517667-eebb301c-8468-11e8-80dd-702215136bc8.gif" width="650">

# 👨‍💻 Author 
[Astemir Eleev](https://github.com/jVirus)

# 🔖 Licence 
The project is availabe under [GNU GENERAL PUBLIC LICENSE](https://github.com/jVirus/skcomponents-kit/blob/master/LICENSE)
