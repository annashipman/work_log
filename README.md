# Work Log

This is a personal project to parse the notes I've been making of how much time
I spend on things.

Contributions are *not* welcome; this is for me to mess
around refreshing my perl skills.

## Usage

`perl -I/$PWD/lib wl.pl [$input_csv $output_scv]`

## Quick start

There is a Vagrant box set up; run the unit tests.

## Unit tests

`perl -I/$PWD/lib tests/test.pl`

## What do I want to know?

How many hours a week I work

How much time I spend on different tasks, depending on how categorised; so I
need first to be able to categorise them.

Occasionally, how much time I've spent on a particular task (e.g. a particular
blog post).

## What have I got?

A CSV with three kinds of row: day, activity with time, blank.

Two types of column: time, activity. Latter is a free text field so needs
categorising. These two columsn only appear in activity rows, not in day rows.

Also some weird stuff while I was on holiday; need to work out what I want to do
with that.

Times are not consistent.

## Make a command line tool with flags

- total hours per day
- total per activity in hours and minutes
- total time on a particular activity
- proportion of time on a particular activity
- proportion of time on all activities

At the moment I'm thinking pipe to one another, i.e. pipe output of one CV
to input of next thing, but that's not very intuitive. Better would be just to
give the correct flags for what I want to do and perhaps always have it parse
the time at the beginning?

## Next steps

Work out how to total per day.
Incorrectly formatted time
A better way to identify time than whether or not it has a hyphen (and/or a way to clean up times before they come in)

