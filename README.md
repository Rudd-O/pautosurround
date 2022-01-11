# Automatic multichannel outputs for PulseAudio

This companion to PulseAudio automatically selects multichannel output profiles for cards
that support them, if the content that is playing back has more than stereo channels.

This helps anyone whose computer is connected to a receiver or preprocessor via HDMI,
such that the receiver does advanced stereo surround audio processing.  When stereo
content is played, the receiver receives a stereo signal and does its normal processing
and upmixing.  When multichannel content is played, the output is automatically switched
to 5.1 multichannel, so that the receiver can play each discrete channel without processing.

The application does nothing with sound outputs with no surround sound output profiles.

## Usage

There is nothing you need to do, really.  You can use the PulseAudio Volume Control
application to verify that your card is in fact changing from stereo to 5.1 when you
play multichannel audio (check that the application is in fact producing 5.1 instead
of downmixed stereo).  When the application ceases to play / exits, you can use the
same Volume Control utility to verify that the card is reset back to stereo after a
few seconds.

## Installation

Build the package using `make rpm`, then install on your system, then restart your
desktop user session.

## License

This software is distributed under the GNU GPL, v2 or later.
