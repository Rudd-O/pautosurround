# Automatic multichannel outputs for PipeWire and PulseAudio

This companion to PipeWire and PulseAudio automatically selects multichannel output
profiles for cards that support them, if the content that is playing back has more
than just stereo channels.

This helps anyone whose computer is connected to a receiver or preprocessor via HDMI,
such that the receiver does advanced stereo surround audio processing.  When stereo
content is played, the receiver receives a stereo signal and does its normal processing
and upmixing.  When multichannel content is played, the output is automatically switched
to 5.1 multichannel, so that the receiver can play each discrete channel without processing.

The application does nothing with sound outputs with no surround sound output profiles.

[You'll find more info about the software here](https://rudd-o.com/linux-and-free-software/initial-release-of-pautosurround-automatic-multichannel-audio-from-pulseaudio).

## Intro

Many people have been, through fortune or hard work, blessed with the opportunity to have a home cinema.

Quite a few of those people run an HTPC with Linux (and PulseAudio / PipeWire — PulseAudio henceforth) on it.  This HTPC tends to be connected — through either HDMI or a multichannel sound card — to an advanced receiver or home theater system, with support for multichannel audio (5.1, 7.1 or more).

If you are fortunate enough to find yourself in this scenario, PulseAudio is fantastic for you.  Through the PulseAudio volume control, it lets you select whether you want your audio to be stereo, or 5.1, or 7.1.  When listening to tunes, you select stereo, and enjoy your home theater's intelligent upmixing of sound.  When watching movies, you select 5.1 or 7.1, and the receiver gets the full multichannel signal from your favorite media player.

As long as you remember to switch to the appropriate profile, you should be good.  But, if you don't, well, things don't sound very well:

* If you play stereo music in multichannel mode, the receiver thinks it's getting multichannel sound, and so it can't intelligently upmix or do Dolby Pro Logic.
* If you play movies in stereo mode, the receiver doesn't get all the channels — you might miss the center channel, the surround sounds will be faked, and you'll get no subwoofer / LFE signal either.

Come to think of it, that's a bit of a bother.  Shouldn't the profile be automatic?  After all, the media player already knows it's either playing stereo sound or multichannel sound.  You already know the computer is connected to a multichannel receiver.  Why can't the computer know to select the appropriate output mode?

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

## Bugs

Currently, the multichannel profile that will be autoselected is the highest-priority
multichannel profile that is available.  This usually is 5.1.  If you want 7.1, well,
that's a bug (or rather, the lack of a feature) I haven't fixed yet.

## License

This software is distributed under the GNU GPL, v2 or later.
