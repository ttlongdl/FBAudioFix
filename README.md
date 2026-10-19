# FBAudioFix

[![Release](https://img.shields.io/github/v/release/ttlongdl/FBAudioFix?label=release)](https://github.com/ttlongdl/FBAudioFix/releases)
![Platform](https://img.shields.io/badge/iOS-17.0%2B-blue)
![Theos](https://img.shields.io/badge/Theos-rootless-informational)

**FBAudioFix v0.3.20** is a standalone iOS tweak that manages Facebook's audio-session behavior so passive autoplay does not unnecessarily interrupt music, podcasts, or YouTube playing in another app.

The goal is simple: **passive Facebook playback should leave other audio alone; intentional Facebook playback should be allowed to take audio focus.**

## What it does

| Scenario | Intended behavior |
| --- | --- |
| YouTube/music playing → browse Facebook News Feed | Passive/autoplay Feed videos do not take exclusive audio focus |
| YouTube/music playing → deliberately open a Feed video | Facebook video can take audio focus and interrupt the other app |
| Return from a Feed video → reopen the same video quickly | Explicit tap is honored even during the short post-release guard; prevents dual-audio regression |
| YouTube/music playing → deliberately open Reels | Intentional Reels playback is allowed |
| YouTube/music playing → open a Story | Explicit Story opening is recognized, including taps before the Story viewer appears |
| Navigate between Stories, mute/unmute, or resume Facebook | Maintains Story audio intent and continuity |
| Leave media for News Feed or background Facebook | Releases Facebook's exclusive audio focus where appropriate |
| Open supported video/deep links | Preserves intentional playback behavior |

### Why the Feed reopen fix matters

After leaving a video, FBAudioFix briefly guards against passive News Feed autoplay stealing audio focus again. In earlier logic, quickly tapping the **same** video a second time could be mistaken for passive autoplay, allowing Facebook and YouTube to play together.

**v0.3.20** adds a narrowly scoped **Feed Video Open Intent**: a confirmed tap on Facebook's video playback container can bypass that guard for a short **1.5-second** intent window. General Feed scrolling and unrelated taps do not receive that exception. Existing Story and Reels intent handling is retained.

## Installation

- **Jailbroken device:** Install the rootless DEB from [Releases](https://github.com/ttlongdl/FBAudioFix/releases) with a compatible package manager.
- **Sideloaded Facebook:** The compiled `FBAudioFix.dylib` can be injected into a compatible Facebook IPA using your own injection/patching workflow.

This tweak has **no settings UI** and does not require changing Facebook's Story start-with-sound preference.

> [!WARNING]
> Do not load FBAudioFix twice. If your Facebook Plus build already integrates FBAudioFix, **do not also install/inject the standalone copy**. Double-hooking `AVAudioSession` may cause unexpected behavior.

## Build from source

Requirements: Theos, an appropriate iOS SDK, and an arm64/rootless-capable toolchain.

```sh
git clone https://github.com/ttlongdl/FBAudioFix.git
cd FBAudioFix
make clean
make package THEOS_PACKAGE_SCHEME=rootless
```

The resulting `iphoneos-arm64` DEB is written to `packages/`. Source builds use `Tweak.xm` and target Facebook as the injection process.

## v0.3.20 release notes

- Fixed the rapid **Feed video → back → reopen same video** case while another app is playing audio.
- Kept the intentional playback rules for **Stories, Reels, and supported deep links**.
- Removed file-based diagnostic probe logging, Story UI scanning, and diagnostic snapshots from the standalone source.
- Kept passive News Feed autoplay suppression and audio-focus release behavior.

The implementation was synchronized with the audio logic tested in [Facebook-Plus](https://github.com/ttlongdl/Facebook-Plus). Tests covered Feed reopen, Story and Reels behavior; this is **not** a guarantee of compatibility with every Facebook app version. Facebook's private UI classes and audio behavior may change between releases.

## Project links

- [Latest releases](https://github.com/ttlongdl/FBAudioFix/releases)
- [Facebook Plus integration](https://github.com/ttlongdl/Facebook-Plus)
- [Issues and bug reports](https://github.com/ttlongdl/FBAudioFix/issues)

## License

MIT
