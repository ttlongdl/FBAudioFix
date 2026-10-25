# FBAudioFix 0.3.21 Experimental — ordered QA protocol

This branch tests whether generic taps (especially static photos) accidentally authorize exclusive Facebook Playback while YouTube is playing.

## Before starting
- Keep YouTube playing continuously in the background; start Facebook on News Feed.
- Use **one** Facebook IPA injected with the experimental FBAudioFix dylib; do not load a second copy.
- Keep the Facebook version, device and iOS constant. Write down the Facebook version and test start time.
- Export the diagnostic log from **Files → On My iPhone → Facebook → FBAudioFix-Diagnostic.log** (the exact filename/location may depend on the IPA's Files exposure). Preserve the .previous rotated log too, if present.
- If YouTube stops, note the step and whether it pauses or only becomes silent. Restart it before the next step.
- Wait 3–5 seconds between actions to avoid overlapping intent windows (Story/Reels: 3 seconds; Feed video: 1.5 seconds).

## Run A — navigation baseline
1. **A1**: While on Feed, tap **Home** tab once. Wait 5 seconds.
2. **A2**: Tap **Reels** tab, watch 5 seconds, return Home. Note whether YouTube pauses.
3. **A3**: Tap **Menu/profile**, return Home. Wait 5 seconds.

## Run B — Feed media discrimination
4. **B1**: Tap a **static photo** in Feed. Stay 5 seconds; back to Feed. Repeat the **same photo** once. Record any YouTube interruption.
5. **B2**: Tap a **Feed video** deliberately. Check that Facebook video audio can take focus. Back to Feed, restart YouTube, then reopen the **same video within 1.5 seconds** (regression test).
6. **B3**: Scroll Feed for 60–120 seconds **without tapping media**. Observe passive autoplay while YouTube plays.
7. **B4**: Tap **Like/comment/text** on a Feed post (without opening a video). Observe whether YouTube continues.

## Run C — Stories and links
8. **C1**: Open a Story tile, then tap to navigate to the next Story. Test mute/unmute. Return to Feed.
9. **C2**: Open a Reel/video through a supported deep link from Safari; confirm intended Facebook audio works. Return to Feed.

## Run D — rare bug observation
10. **D1**: Browse Feed normally with YouTube playing for 10–20 minutes, including occasional static-photo taps. If interrupted, note the last tap and approximate time. Export log immediately afterward.

## What to look for in logs
- `TAP confirmed`, `PHOTO TAP diagnostic nonMedia=YES`
- `FEED VIDEO OPEN intent armed`, `REELS TAB media intent`, `STORY OPEN tileTap`
- `DECISION suppress reason=noExplicitMediaIntent` while `otherAudio=YES` for static photos / generic taps
- `DECISION allow` for deliberate video / Reels / Story actions
- `Playback ALLOW` or `Playback SUPPRESS` after each action

**Expected:** A1/A3/B1/B3/B4 should not interrupt YouTube. A2/B2/C1/C2 should preserve intended Facebook media audio, and B2 rapid reopen must not cause unwanted simultaneous YouTube + Facebook audio.

**Important:** Logs record FBAudioFix decisions, not YouTube's internal player state. Pair the log with manual observations. Do not publish 0.3.21 as stable until the intentional-media regressions pass.
