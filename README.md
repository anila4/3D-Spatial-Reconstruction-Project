<img width="772" height="478" alt="image" src="https://github.com/user-attachments/assets/a4dc0371-a69a-49d5-9130-8b33a3930318" /># 3D-Spatial-Reconstruction-Project
Using a TI MSP432e401Y RISC-V microcontroller to control a Time of Flight sensor and stepper motor, distance scans can be taken of the surrounding space, then relayed to a MATLAB script to create a 3D map of the area.

This is an embedded scanning system capable of recreating an approximate 3D reconstruction of rooms or enclosed areas with 0.1 mm accuracy. It is similar in principle to a LiDAR system, using a time of flight sensor mounted on a stepper motor to take multiple distance measurements across a full 360 degree rotation. Measurement data is transmitted from the sensor to the microcontroller using I2C communication protocols. Each measurement contains the necessary measurements for the YZ Plane, whilst taking multiple scans produces the necessary X-axis measurements.

These measurements are collected and sent to a MATLAB script, which creates an empty cartesian plane, then plots the measurement data points in polar form, creating a 3D map of the sacnned area. 

# Images
<img width="681" height="502" alt="image" src="https://github.com/user-attachments/assets/ff84be84-5da6-4227-8978-aa4638c3b0eb" />
The following image displays both the microcontroller used to control the device, and the frame of the device containing the stepper motor and TOF sensor

<img width="772" height="478" alt="image" src="https://github.com/user-attachments/assets/ffe6e303-a75b-4fab-a925-1846fdcc87cd" />
A flow chart displaying the data transmission and usage within the entire system

<img width="397" height="303" alt="image" src="https://github.com/user-attachments/assets/e6b761e0-9217-4523-b9a6-9bca4194b185" />
The test area scanned to verify accuracy of measurements and area reconstruction

<img width="773" height="358" alt="image" src="https://github.com/user-attachments/assets/773d933a-e9cc-47a5-b011-ba5e7776e55d" />
<img width="763" height="417" alt="image" src="https://github.com/user-attachments/assets/fed84169-5b98-4422-ac61-e263da2c49f0" />
The scans taken by the system




