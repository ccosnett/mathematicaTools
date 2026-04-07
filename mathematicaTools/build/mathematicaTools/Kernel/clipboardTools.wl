(* ::Package:: *)

BeginPackage["mathematicaTools`clipboardTools`"];
Unprotect["mathematicaTools`clipboardTools`*"]; ClearAll["mathematicaTools`clipboardTools`*"]; ClearAll["mathematicaTools`clipboardTools`Private`*"]; ClearSystemCache[];


Begin["`Private`"];
Needs["mathematicaTools`"];

copyCell[str_] := (
    CopyToClipboard[str];
    CellPrint[
        Cell[
            str,
            "Text",
            Evaluatable -> True,
            CellEvaluationFunction -> copy
        ]
    ];
    SelectionMove[EvaluationCell[], All, EvaluationCell];
    NotebookDelete[];
    SelectionMove[EvaluationNotebook[], Next, CellContents]
);

copy[str_, _] := CopyToClipboard[str];
copy[str_] := CopyToClipboard[str];

AdjanSumedo := copyCell["Hello,

Thank you for contacting Wolfram Technical Support.

In order to help you, I propose we arrange a Zoom meeting at your earliest convenience.

For your ease, I have attached my scheduling link below, which displays my availability. Please feel free to choose a suitable timeslot that works best for you.

Link: https://calendly.com/conor_cosnett_/30min


Many thanks,

Conor Cosnett
Wolfram Technical Support
Wolfram Research Inc.
https://support.wolfram.com/
"];


End[];
EndPackage[]
