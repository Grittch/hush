# Hush

Android app that plays the WhatsApp voice notes you received without opening WhatsApp.

A text message can be read from the notification shade, so you decide if and when to reply. A voice note forces you into the chat, and once you are there the sender sees that you listened. Hush reads the voice notes WhatsApp already saved on the phone, so you can listen on your own time.

## How it works

On first launch you pick the folder where WhatsApp keeps received voice notes, using the system folder picker. The path is not hardcoded because it changes between Android versions, manufacturers and WhatsApp Business.

Access is read only. Files are copied into the app cache to be played, and nothing inside the WhatsApp folders is ever written, renamed or deleted.

Listened state and resume position are kept by Hush in a local database. WhatsApp does not expose them, and listening here sends no signal back to the sender.

## What it does not do

It does not show who sent a voice note. WhatsApp file names carry only a date and a counter, like `PTT-20260811-WA0001.opus`, and the link between a file and a contact lives in an encrypted database that Hush cannot read. Voice notes you recorded yourself may sit in the same folder as the ones you received, with no reliable way to tell them apart.

Times come from the file modification date, which a backup restore rewrites. When that date disagrees with the date in the file name, Hush shows no time instead of a wrong one.

Durations are measured in the background for the most recent voice notes. Older ones show their duration the first time you open them.