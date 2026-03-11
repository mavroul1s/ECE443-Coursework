# ECE443 Speech and Audio Processing

**Author:** Nikos Mavros
**Institution:** University of Thessaly, Department of Electrical and Computer Engineering

## Description

This repository contains the coursework and assignments for the ECE443 Speech and Audio Processing course. The projects explore fundamental concepts in signal analysis, frequency-domain representations, and time-domain modifications, providing a practical foundation in digital signal processing (DSP). This repository serves as a comprehensive portfolio of audio processing techniques, establishing the algorithmic groundwork needed for advanced studies in generative AI and machine learning within the audio domain.

## Repository Structure

```text
ECE443_Speech_and_Audio_Processing/
|-- README.md
|-- Assignment_1/
|   |-- src/
|   |   |-- Assignment1_question1.m
|   |   |-- Assigment1_question2.m
|   |-- images/
|   |   |-- narrowband1edited.jpg
|   |   |-- wideband1edited.jpg
|   |   |-- narrowband2editedd.jpg
|   |   |-- wideband2edited.jpg
|   |   |-- apa_slowed_edited.png
|   |-- report/
|       |-- Assigment1_NIKOS_MAVROS_03741.pdf
|-- Assignment_2/
|   |-- src/
|   |   |-- my_lpc.m
|   |   |-- QUESTION2.m
|   |   |-- QUESTION3.m
|   |   |-- QUESTION4.m
|   |   |-- TEST1.m
|   |   |-- TEST2.m
|   |   |-- TEST3.m
|   |   |-- TEST4.m
|   |-- audio/
|       |-- sample.wav
|       |-- lpc_output.wav
|       |-- robot_order4.wav
|       |-- robot_order16.wav
|       |-- robot_order40.wav
|       |-- whisper_order2.wav
|       |-- whisper_order60.wav
|       |-- my_voice.wav
|       |-- my_robot_voice.wav
|-- Assignment_3/
|   |-- presentation/
|       |-- good_vibrations.pdf

```

## Assignment 1: Spectrogram Analysis and Time-Domain Modifications

This assignment explores the use of short-time Fourier transforms (STFT) to analyze speech signals and investigates the time-domain characteristics of periodic and impulsive speech sounds. 

### Question 1: Spectrogram Analysis
The first part of the assignment involves generating and analyzing narrowband and wideband spectrograms for two distinct audio samples ("add" and "cats"). The MATLAB script `Assignment1_question1.m` computes these spectrograms using 25 ms windows for narrowband and 5 ms windows for wideband analysis.

**Key Observations:**
* [cite_start]**Sample 1 ("add"):** The fundamental frequency (F0) is measured by calculating the vertical spacing between consecutive harmonics in the narrowband spectrogram, yielding approximately 250 Hz[cite: 71, 72]. 
* [cite_start]**Sample 2 ("cats"):** The fundamental frequency is approximately 160 Hz[cite: 74]. [cite_start]The harmonics are more densely packed, indicating a lower pitch[cite: 76, 77].
* [cite_start]**Speaker Identification:** Based on the lower F0 and lower formant frequencies, sample 2 is identified as a male speaker, while sample 1 is identified as a female speaker[cite: 78].

**Image Links:**
* [View Narrowband Spectrogram for Sample 1](Assignment_1/images/narrowband1edited.png)
* [View Wideband Spectrogram for Sample 1](Assignment_1/images/wideband1edited.png)
* [View Narrowband Spectrogram for Sample 2](Assignment_1/images/narrowband2editedd.png)
* [View Wideband Spectrogram for Sample 2](Assignment_1/images/wideband2edited.png)

### Question 2: Time-Domain Analysis of Speech Segments
The second part involves recording the word "apa", segmenting it, and modifying its playback speed. The MATLAB script `Assigment1_question2.m` handles the recording, plotting, and applying a slow-down factor of 2 to the signal.

**Key Observations:**
* [cite_start]**Periodic Segments:** The vowel parts ("a") display smoother, periodic oscillations, which correspond to the periodic vibration of the vocal folds[cite: 161].
* [cite_start]**Impulsive Segments:** The consonant part ("p") appears as a short, low-energy, impulsive segment[cite: 162].

**Image Links:**
* [View Slowed-Down Signal Analysis](Assignment_1/images/apa_slowed_edited.png)

---

## Assignment 2: Linear Predictive Coding (LPC) and Speech Synthesis

This assignment dives into the source-filter model of speech using Linear Predictive Coding (LPC). By separating the excitation signal (the "source" from the vocal cords) from the spectral envelope (the "filter" from the vocal tract), the original speech is reconstructed, and the excitation is modified to synthesize entirely new vocal effects.

### Part 1: Standard LPC Analysis and Synthesis (`my_lpc.m`)
The `my_lpc.m` function implements standard LPC analysis and synthesis. It processes the input audio in 30 ms overlapping frames. The Levinson-Durbin recursion extracts the LPC coefficients and the linear prediction error. The audio is reconstructed by passing the prediction error back through the all-pole filter, resulting in synthesized speech that sounds nearly identical to the original.

### Part 2: "Robot Voice" Synthesis (`QUESTION2.m`)
To create a robotic effect, the original vocal cord excitation is replaced by a synthetic, perfectly periodic impulse train. A constant pitch period of 120 Hz is used across all frames, flattening the natural intonation. Varying the LPC order demonstrates that a low order (e.g., 4) produces a muffled sound, while a high order (40) produces a crisp, detailed robotic buzz.

### Part 3: "Whisper" Synthesis (`QUESTION3.m`)
To simulate a whisper, the excitation signal is replaced with random white noise. Replacing the periodic excitation with noise removes strong periodicity and pitch cues. However, because the LPC filter preserves the formant structure, the speech remains intelligible. Higher LPC orders capture greater spectral detail compared to lower orders, which smooth out the envelope too much.

### Part 4: Live Recording and Application (`QUESTION4.m`)
This section applies the theory to a live recording. The script records 3 seconds of audio and directly applies the 120 Hz "Robot Voice" effect. While the pitch is artificially flattened, personal vocal characteristics like accent and speaking speed are preserved by the LPC filter.

---

## Assignment 3: Presentation - Good Vibrations from Electronic Circuits

[cite_start]This assignment is a presentation based on the paper *Good Vibrations from Electronic Circuits* by Carsten Deckert, published in 2004[cite: 192, 193]. It explores the historical evolution and design philosophies of electronic synthesizers.

**Key Topics Covered:**
* [cite_start]**The Theremin (1920):** The first step toward electronic music, allowing sound manipulation without physical contact[cite: 206, 207, 208]. [cite_start]This instrument set the foundations for oscillators[cite: 210].
* [cite_start]**Modular Synthesizers:** An exploration of early systems where every function was a separate module, characterized by a "spaghetti" of patching cables[cite: 213, 214, 215]. [cite_start]While offering unlimited freedom, they were limited by their massive size, high cost, and lack of memory storage[cite: 216, 218, 219].
* [cite_start]**Subtractive Synthesis:** The process of starting with a harmonic-rich source (VCO), using a filter (VCF) to remove frequencies, and using a modifier (VCA) to shape volume over time[cite: 224, 226, 227, 228]. [cite_start]This includes the ADSR envelope: Attack, Decay, Sustain, and Release[cite: 229, 233, 234, 237, 238].
* [cite_start]**Moog vs. Buchla:** A comparison of the East Coast approach (Moog), which adapted to traditional keyboard performance and subtractive synthesis for music production [cite: 242, 244, 246, 247][cite_start], versus the West Coast approach (Buchla), which avoided keyboards in favor of touch plates and complex wavefolding for absolute experimentation[cite: 248, 249, 250, 252].
* [cite_start]**The Minimoog & Digital Era:** The Minimoog (1970) made synthesizers portable by removing patch cables and stabilizing the signal flow[cite: 255, 258, 259, 260]. [cite_start]Later, the Yamaha DX7 (1983) marked the digital era, introducing presets and solving polyphony limitations[cite: 268, 270].
* [cite_start]**The MAYA Principle:** "Most Advanced, Yet Acceptable" explains the commercial success of synths like the Moog and DX7, which balanced new technology with familiar, accessible interfaces[cite: 271, 272, 273, 274].
* [cite_start]**My Synthesis Rig:** A breakdown of a personal analog setup, featuring a Behringer RD6 drum machine and a Behringer TD3 bass line synthesizer synchronized via a Master-Slave connection[cite: 279, 280, 281, 284].
