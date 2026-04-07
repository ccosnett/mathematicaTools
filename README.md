# mathematicaTools

Small Wolfram Language paclet for personal Mathematica notebook utilities.

## Load the paclet locally

Use this exact absolute path on this machine:

```wl
PacletDirectoryLoad["/Users/johncosnett/PycharmProjects/mathematicaTools"];
Get["mathematicaTools`"];
```

## Reinstall the paclet

These are the Wolfram Language commands used in
`scripts/paclet_generation_procedure.nb`.

They assume you are running from that notebook, so `NotebookDirectory[]`
resolves inside `scripts/` and the parent directory is the repo root.

```wl
name = "mathematicaTools";

PacletUninstall[name];

DeleteDirectory[
    ParentDirectory[NotebookDirectory[]] <> "/" <> name <> "/build/",
    DeleteContents -> True
];

directory2 = ParentDirectory[NotebookDirectory[]] <> "/" <> name;
PacletBuild[directory2];

dir = ParentDirectory[NotebookDirectory[]] <> "/" <> name;
PacletInstall[
    dir <> "/build/" <> name <> "-0.0.1.paclet",
    ForceVersionInstall -> True
];
```

## Try the new clipboard helper

```wl
AjahnSumedho
```

This copies the predefined support message to the system clipboard and prints
an evaluatable text cell, following the same interaction pattern used by the
other notebook helpers in this paclet.

## Other exported symbols

```wl
Names["mathematicaTools`*"]
```
