# mathematicaTools

Small Wolfram Language paclet for personal Mathematica notebook utilities.

## Load the paclet locally

Use this exact absolute path on this machine:

```wl
PacletDirectoryLoad["/Users/johncosnett/PycharmProjects/mathematicaTools"];
Get["mathematicaTools`"];
```

## Reinstall the paclet

Use these absolute paths if you want the reinstall command to work from any
notebook on this machine.

```wl
name = "mathematicaTools";
repoDir = "/Users/johncosnett/PycharmProjects/mathematicaTools/mathematicaTools";
buildDir = repoDir <> "/build";
pacletFile = buildDir <> "/" <> name <> "-0.0.1.paclet";

Get["PacletTools`"];

PacletUninstall[name];

DeleteDirectory[
    buildDir,
    DeleteContents -> True
];

PacletBuild[repoDir];
PacletInstall[
    pacletFile,
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
