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

AjahnSumedho := copyCell["Hello,

Thank you for contacting Wolfram Technical Support.

If helpful, I would be glad to arrange a Zoom meeting.

You can choose a suitable time here:

Link: https://calendly.com/conor_cosnett_/30min


Kind regards,

Conor Cosnett
Wolfram Technical Support
Wolfram Research Inc.
https://support.wolfram.com/
"];


End[];
EndPackage[]
