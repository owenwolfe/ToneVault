# ToneVault

## Project Members

Owen Wolfe

## Project Description

ToneVault is a mobile application for electric guitar players to save, organize, and recreate guitar tones. Guitarists often adjust many different settings across their guitars, amplifiers, and pedals to create a particular tone, but it can be difficult to remember the exact settings later. ToneVault will provide a common place for users to record these configurations and quickly find them again.

Users will be able to create saved tones containing information such as:

* Tone name
* Song or artist associated with the tone
* Guitar and pickup used
* Amplifier settings
* Pedal settings
* Additional notes
* Audio recording of the tone

Users may also use ToneVault to save files for digital presets such as THR and Katana models.

Users will be able to organize, search, and filter their saved tones. When viewing a tone, users can play back its audio recording and use a guided recreation view that displays the saved amp and pedal settings to help recreate the tone.

### Backend and Internet Connectivity

ToneVault will use Firebase as its backend. User accounts will be handled through Firebase Authentication, while tone information will be stored using Cloud Firestore. Users will send and receive data from the backend when creating, editing, deleting, and viewing their saved tones. Each tone will be associated with the user who created it.

Audio recordings, photos, and preset files will be stored online and associated with the corresponding saved tone and user.

### Camera and Microphone Integration

ToneVault will use the device's camera and microphone. Users will be able to take photos of their amplifier, pedalboard, or individual pedals to record knob positions and other settings that may be difficult to describe with only text. Users will also be able to record a short audio sample of their guitar tone to use as a reference when recreating it later.

These photos and recordings will be stored online and associated with the corresponding saved tone and user. This will allow users to use their recorded settings, photos, and audio when trying to recreate a guitar tone.
