# Overall impressions

## It's British?

I've seen it spelling things British-ly:  programme, defence, etc.

## It works pretty well on CPU
I'm sure it works better on a GPU but it's quite tolerable on a multicore
CPU setup ... like my laptop.  Generally the processes are using ~7.5 cores.

## It's really slow on non-speech audio
For things like music and white noise it takes a long time to decide
there's no speech there.  

## It's repetitive sometimes
When it gets confused (by non-speech audio) it will reuse a phrase it has seen 
before.  01-Tom_Sawyer.mp3 is a good example.

## Phrase-level mondegreens
In cases where it is making a blind guess on what it heard it will substite 
what is likely a training phrase.  05-Du_hast.mp3 is a good example.

## Language model size makes a difference
The small model (default) is pretty good and reasonably fast on non-musical
audio.  

The medium model is noticibly slower but provides a much better output.  

The large model takes a ton of time (and ram...~9-10G)

I should probably come up with some actual numbers, but that's what I'm seeing 
when I listen/read to the material.

## The language model has more hidden underneath it
One of the features is that it can do a translation of the transcription into
English.  That means it /has/ to know what kind of words they are.  So NER
might be able to be derived from that information.  Numbers are rendered as
digits so that may be more evidence of additional information there.  It also
knows when things are supposed to be names.



# Audio samples

## gettysburg.wav
This was generated from a download from an NPR segment on the gettysburg
address.
https://www.npr.org/2003/11/19/1512410/a-reading-of-the-gettysburg-address

That site has a rough transcript and the audio.

Generally this does really well with the audio since it's pretty clean overall.

EXCEPT

For some reason the small and medium models skipped the last paragraph entirely.

## ffa.mp4
Video from MDPI of an FFA Event.  Lots of white noise.  MDPI_45000000312345_01_access.mp4

There isn't a ground truth, but spot checking it seems to show it does alright.
Names are a little iffy, but it *does* recognize that some things are names even
if it spells them wrong.

The only oddity is that it repeats previously seen phrases when there's applause
or music it doesn't understand.


## I_Do_Care_Social_Responsibility_Spanish_Media_Collecti.mp4
https://media.dlib.indiana.edu/media_objects/f7623z934


In spanish, curious if it will figure that out....it doesn't.  Decides English.
Probably because the first 22s is bars and tone, the next 13 seconds are title
card.  Dialog doesn't begin until 54...in a "presentation of" clip where
english is in the left channel and spanish is in the right.

When I force it to spanish it does output stuff that I recognize as spanish.
No idea on accuracy.

When translating to english, I'm getting something that makes reasonable
sense

```
[12:36.840 --> 12:37.840]  Mom, I'm sorry.
[12:37.840 --> 12:39.840]  Teresa, what happened?
[12:39.840 --> 12:40.840]  Eduard.
[12:40.840 --> 12:42.840]  Eduard, what were you doing with Eduard?
[12:42.840 --> 12:43.840]  Listen to me, Mom.
[12:43.840 --> 12:44.840]  They hurt him.
[12:44.840 --> 12:46.840]  The man who was with her daughter sold drugs.
[12:46.840 --> 12:47.840]  Drugs?
[12:47.840 --> 12:48.840]  Is Eduard dead?
[12:48.840 --> 12:50.840]  No, but his car was destroyed.
```



## Lincoln_s_Gettysburg_address_Library_of_Congress.mp3
https://www.loc.gov/item/jukebox-262416/

This is off a scratchy 78 and it's got that weird accent that seemed to be 
popular among public speakers in the early 1900s...the one that makes me inject
"IS FEAR ITSELF!" randomly during pauses.

In any case, the large model nails it.  The medium model missed one word and
the small model only missed around 4 words.


## 01-9028-Chapter_3H_-_The_Letters_From_No_One.mp3
Part of the Harry Potter and the Sorcerer's Stone audio book.  Jim Dale uses 
different voices for different characters and with an accent.

"Armpitunia" is actually really funny.

Overall transcription is pretty good in medium, with more than 98% vs the
ground truth I snagged from the web.  Most of the differences are the british
words/spelling...like "ploughed".



## 01-Tom_Sawyer.mp3
Rush.  Picked because Geddy is hard to understand sometimes and it's one of my
favorite songs, so I can listen to it a bunch.

During the solo lines are added which it had seen previously.

In the small model:
```
Love and life are deep
Love and life are deep
Love and life are deep
```

In the medium model:
```
Love and life are deep
Love and life are deep
```

In the large model:
```
He s reserved a quiet defense riding out the day s events
The world is the world is love and life are deep maybe as its skies are wide
```

"Thanks for watching!" added to the end for some AI reason in the large and
medium models, but it re-uses "Love and life are deep" in the small model.


## 06-Kodachrome.mp3
Paul Simon.  Mostly acoustic background.  Plus, Kodachrome and Nikon are
registered trademarks which may or may not be in the vocabulary.

Small missed both of the trademarks, but Medium hit Kodachrome.


## 05-Du_hast.mp3
Rammstein.  German Language.
Lyrics start @ 31s which is beyond the language detection and thus it guesses
English.  It then transcribes badly:

```
[00:00.000 --> 00:12.260]  Thanks for watching and Don't Forget to Like And Subscribe to
[01:00.000 --> 01:12.000]  Thanks for watching and Don't Forget to Like And Subscribe to
[01:30.000 --> 01:50.000]  Thanks for watching and Don't Forget to Like And Subscribe to
[01:50.000 --> 02:18.000]  Thanks for watching and Don't Forget to Like And Subscribe to
[02:48.000 --> 03:08.000]  Thanks for watching and Don't Forget to Like And Subscribe to
[03:08.000 --> 03:28.000]  Thanks for watching and Don't Forget to Like And Subscribe to
[03:28.000 --> 03:54.000]  Thanks for watching and Don't Forget to Like And Subscribe to
```

Which makes absolutely no sense.  The song is instrumental until 00:31 -- so 
something triggered a training phrase to get inserted.  

With the German small model it has reasonable output, but the medium model
drops the ball for the first 90 seconds and then starts doing a really nice
job.

Using the large model had more than 3 hours of CPU time before finding anything
and I shut it down.

## StarWars.m4v
This is a rip of Star Wars DVD (pre-1990's butchering).  There are a lot of
unnatural sounds and artificial languages to try to trip it up.  Ooo-tay-dee!

OK, that's weird .. it thinks it's in latin.  The first 30 seconds has the fox
intro and then the start of the main theme.  No speech at all.  Other things
I've tested where there wasn't any speech just fell back to english.  No dialog 
until 2:49.

This kind of bothers me, actually.  I don't think there's a way to say always
default to english if you don't detect something else well.    

The small model didn't find any speech in the first 8 minutes using the small 
model.  small.en didn't work either.

Using the medium.en model, it decided that the theme is actually 
"Pomp and Circumstance".  It's pretty slow but it is processing.  It is picking
up sound effects as words sometimes:

```
[03:08.000 --> 03:11.000]  There'll be no escape for the princess this time.
[03:13.000 --> 03:15.000]  What's that? <-- correctly C3PO
[03:19.000 --> 03:21.000]  Everybody in here.  <-- background music triggers it
[03:45.000 --> 03:46.000]  Wait! <-- explosion of Tantive IV's hatch
```

It does know proper words like "Death Star".  I wonder what training did that:
```
[04:57.000 --> 04:59.000]  R2-D2, where are you?
...
[05:42.000 --> 05:44.000]  The Death Star plans are not in the main computer.
...
[06:32.000 --> 06:35.000]  She'll be all right. Inform Lord Vader we have a prisoner.
...
[07:39.000 --> 07:42.000]  Darth Vader, only you could be so bold.
[07:42.000 --> 07:44.000]  The Imperial Senate will not sit still for this.
...
[07:59.000 --> 08:02.000]  I'm a member of the Imperial Senate on a diplomatic mission to Alderaan.
[08:02.000 --> 08:06.000]  You are part of the Rebel Alliance and a traitor. Take her away!
```




# Results information

All of the directories in the results directory are based on the filename and
the model used.  The file ending with .out is the output of the command itself
and the rest are the files generated by whisper.

The length of processing time is available as the last line of the .out file:

```
22241.38user 3041.32system 1:09:55elapsed 602%CPU (0avgtext+0avgdata 10434000maxresident)k
2539392inputs+56outputs (5134major+880153454minor)pagefaults 0swaps
```

Real time perormance is the elapsed value (1:09:55) and how much active CPU was
used.  For comparison purposes, it is better to add the number of cpu seconds
for both user and system since that will be the same no matter how many CPU
cores are available  (22241.38 + 3041.32 = 25282.70 cpu seconds).  

# Comparison stuff

the files in the comparisons directory are all compared to a ground truth, if
there is one, using the source filename and model as the filename.

In the file, `[-in-]` indicates that the word 'in' was in the ground truth and
`{+into+}` was in the file being compared.  

At the end of the file there are statistics (the first line is ground truth 
and the second is the compared file)

