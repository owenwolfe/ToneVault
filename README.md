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

## Project Implementation Details

ToneVault will be developed as an Android application using Flutter and Dart. Firebase will provide the internet-based services used by the application.

Firebase Authentication will be used to create and manage user accounts. Cloud Firestore will store information about each saved tone. Firebase Storage will be used for larger files such as photos, audio recordings, and digital preset files.

The main Firestore collection will be a `tones` collection. Each tone document will contain fields such as:

* `userId`
* `name`
* `artist`
* `song`
* `guitar`
* `pickup`
* `ampSettings`
* `pedalSettings`
* `notes`
* `category`
* `photoUrl`
* `audioUrl`
* `presetUrl`

The `userId` field will associate each saved tone with the user who created it. URLs stored in the tone document will connect the tone with files stored using Firebase Storage.

## User Interface

ToneVault will contain several views that allow the user to interact with their saved tones.

### Login / Sign Up

Allows users to create an account or log into an existing account.

### Tone Library

Displays the user's saved tones and allows them to search and filter their collection. Users can select an existing tone or create a new one.

### Create / Edit Tone

Allows the user to enter information about a tone, including the guitar, amplifier, pedals, and other settings. Users can also take photos and record an audio sample from this view.

### Tone Details

Displays all saved information for a tone, including settings, photos, notes, and audio playback.

### Tone Recreation

Provides a simplified view of the saved amplifier and pedal settings that the user can reference while recreating the tone.

### Search and Filter

Allows users to search for tones and filter their library using information such as artist, song, guitar, or category.

## Project Deliverables

### Expected Deliverables

The expected deliverables represent the features required for the minimum viable version of ToneVault.

* Flutter Android application
* User registration and login using Firebase Authentication
* Create, edit, view, and delete saved tones
* Store and retrieve tone information using Cloud Firestore
* Tone library displaying saved tones
* Camera integration for taking equipment photos
* Audio recording and playback
* Firebase Storage for photos and recordings
* Search and filter saved tones
* Tone recreation view

### Stretch Goals

If the expected functionality is completed, additional features may include:

* Uploading and downloading digital amplifier preset files
* Sharing tones with other ToneVault users
* More advanced tone categories and organization
* Improved visual controls for displaying amplifier and pedal settings
