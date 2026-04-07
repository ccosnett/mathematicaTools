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

ajahnSumedho := copyCell["Rephrase the whole email.

Do not be verbose or repetitive.

Be simple, in the manner of the Buddhist monk Ajahn Sumedho.

Be professional and honourable.

Do not sound like a New Age hippie.
"];


End[];
EndPackage[]
