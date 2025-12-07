# Game Programming 2 – Portfolio Project  
**Student:** Ehsan Faizee  
**Course:** 420-540-LE – Game Programming 2  
**Semester:** Fall 2025  
**Instructor:** Francis Gauthier  

---

## About This Portfolio

This portfolio is a **single Godot application** that acts as a launcher for multiple games I have created or participated in during Game Programming 1 & 2.  
The main menu provides access to each game, external executables, and supplemental materials such as GitHub links and documentation.

This README file will be used to:

- Document all work done  
- Provide explanations and progress for the 10 learning objectives  
- Describe the games included  
- Record issues, improvements, and weekly updates  
- Offer instructions for evaluating the portfolio  
- Track versions and changes throughout the project  

---

#Project Structure Overview

```
Portfolio/
│   project.godot
│   README.md   <-- This document
│
├── MainMenu/          # Main menu scenes & UI
├── Game1/             # Internal Godot game 1 (source code)


- **Internal games** (Godot scenes) are loaded using  
  `SceneManager.change_scene("res://Game1/Main.tscn")`
- **External .exe games** are launched using  
  `OS.create_process("./Executables/Game3.exe", [])`

---

#Games Included in This Portfolio

### **Game 1 – (Platformer)**
- Built fully in Godot  
- Main scene: `res://Game1/Main.tscn`  
- Features: (add short description)

### **Game 2 – (not yet)**
- Built fully in Godot  
- Main scene: `res://Game2/Main.tscn`  
- Features: (add short description)

### **Game 3 – (Adventurer)**  
*(External Executable)*  
- Launched with `OS.create_process()`  
- Located in: `/Executables/Game3.exe`  
- Features: (This game was developped in winter winter 2024 showcases all four different levels to for adventure.)

### **Game 4 – (Ghost)**  
*(External Executable)*  
- Launched with `OS.create_process()`  
- Located in: `/Executables/Game4.exe`  
- Features: (add short description)
