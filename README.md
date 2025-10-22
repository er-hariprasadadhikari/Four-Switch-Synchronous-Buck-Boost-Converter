# Four Switch Synchronous Buck–Boost Converter with Closed Loop Feedback

## 📘 Abstract
This project focuses on the design and implementation of a **Four-Switch Synchronous Buck–Boost Converter** that can operate efficiently in both buck (step-down) and boost (step-up) modes. By integrating **synchronous rectification** and **closed-loop voltage feedback control**, the converter achieves improved voltage regulation, reduced switching losses, and higher efficiency compared to traditional topologies.  

The converter uses **Arduino Nano** for control, **IR2104** MOSFET drivers, and **IRFZ44N** MOSFETs as switching elements. Simulations are carried out in **MATLAB/Simulink** and **Proteus**, while real hardware implementation validates the results.

---

## ⚙️ System Overview

### 🧩 Hardware
- **Microcontroller:** Arduino Nano (ATmega328P)
- **MOSFETs:** IRFZ44N (N-channel, 49A, low RDS(on))
- **Driver IC:** IR2104 Half-Bridge MOSFET Driver
- **Voltage Regulator:** LM317
- **Feedback Sensor:** Voltage divider and ADC input to Arduino
- **Additional Components:** Inductor, capacitors, bootstrap circuit, pull-down resistors

### 💻 Software
- **MATLAB/Simulink:** For small-signal modeling and converter simulation
- **Proteus 8 Professional:** For circuit design and verification
- **Arduino IDE:** For PWM generation, feedback control, and data monitoring

---

## 🎯 Objectives
1. Develop a four-switch synchronous buck–boost converter with closed-loop feedback.
2. Reduce switching and conduction losses using synchronous rectification.
3. Achieve high efficiency and fast dynamic response.
4. Validate results through MATLAB simulation, Proteus design, and hardware prototype.

---

## 🧠 Methodology
- **Control Technique:** Voltage Mode Control (VMC) with PWM feedback loop.
- **Closed Loop Feedback:** Output voltage is sensed and compared to reference; Arduino adjusts PWM duty cycle dynamically.
- **Bootstrap Circuit:** Generates high-side gate drive voltage.
- **Cross-Conduction Prevention:** Implemented via dead-time control in the MOSFET driver.
- **Soft Start:** Gradual PWM ramp-up to avoid inrush current and overshoot.

---

## 📊 Efficiency Results
| Mode | Input (V) | Output (V) | Efficiency |
|------|------------|-------------|-------------|
| Buck | 12 → 5.9V  | 92–93%      |
| Boost| 12 → 23.8V | 85–89%      |

---

## 📁 Repository Structure

```
Four-Switch-Buck-Boost-Converter/
├── 📄 README.md
├── 📁 Documentation/
│   ├── 📄 FINAL_YEAR_PROJECT_FSBBConverterREVISED.pdf
│   └── 📄 Project_Presentation.pdf (placeholder)
├── 📁 Simulation/
│   ├── 📁 MATLAB/
│   │   ├── 📄 Buck_Converter_Model.slx
│   │   ├── 📄 Boost_Converter_Model.slx
│   │   ├── 📄 FSBB_Converter_Model.slx
│   │   └── 📁 Scripts/
│   └── 📁 Proteus/
│       ├── 📄 FSBB_Converter_Design.pdsprj
│       └── 📁 Screenshots/
├── 📁 Firmware/
│   └── 📁 Arduino/
│       └── 📄 FSBB_Converter_Code.ino
├── 📁 Hardware/
│   ├── 📄 Schematic.pdf
│   ├── 📁 PCB/
│   └── 📁 Datasheets/
└── 📁 Images/
    ├── 📄 hardware_prototype.jpg
    ├── 📄 block_diagram.png
    └── 📄 flowchart.png
```

---

## 🧑‍🔬 Team Members
- **Abishek Raj Koirala (PUR076BEL002)**
- **Bishal Khanal (PUR076BEL010)**
- **Hari Prasad Adhikari (PUR076BEL018)**
- **Nishan Bhattarai (PUR076BEL030)**

**Supervisor:** Er. Deependra Neupane  
**External Examiner:** Dr. Ing. Deepranjan Dongol  
**Department:** Electrical Engineering, IOE Purwanchal Campus, Tribhuvan University

---

## 📜 License
This project is shared for academic and research purposes. All rights reserved by the authors and the Department of Electrical Engineering, IOE Purwanchal Campus.
