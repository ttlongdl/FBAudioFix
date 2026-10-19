# FBAudioFix

Standalone rootless iOS tweak for Facebook audio-session arbitration. Version **0.3.20**, ported from the tested **Story Audio Intent v2.1** logic in [Facebook-Plus `next`](https://github.com/ttlongdl/Facebook-Plus/tree/next/addons).

## Behavior

- Prevents passive News Feed autoplay from taking exclusive audio focus from YouTube and other background audio apps.
- Allows intentional Facebook media playback from video taps, Reels tab and supported inbound video/deep links.
- Handles Story audio intent, Story mute/unmute and continuity through Story changes, media reloading and Home → Facebook transitions.
- Recognizes taps on Story tiles before Story viewer appears, allowing explicit Story launches to bypass the short News Feed post-release guard.
- Recognizes deliberate News Feed video taps and allows reopening the same video during the post-release guard without mixing with YouTube audio.
- Releases audio focus on leaving media for News Feed or putting Facebook in background.
- Honors Story start-with-sound behavior; no Facebook settings override is required.

## Build

Requires Theos, iOS SDK and rootless toolchain:

```sh
make clean
make package THEOS_PACKAGE_SCHEME=rootless
```

Outputs an `iphoneos-arm64` DEB. `FBAudioFix.dylib` can also be injected into a Facebook IPA. No preference bundle.

## Release notes

This standalone release includes the tested explicit Feed video reopen fix and removes file-based probe logging, Story UI scanning and diagnostic snapshots, while retaining the audio, tap, Story lifecycle, Reels, inbound link, and session arbitration hooks from the tested integrated v2.1.

**Important:** Do not enable two copies of the audio fix at the same time (for example this standalone tweak alongside a Facebook Plus build that already bundles FBAudioFix). Double-hooking `AVAudioSession` can cause unpredictable behavior.

Verified behavior is based on real-world user tests, not exhaustive compatibility testing. Facebook internal UI structures can change in later releases.

## License

MIT
