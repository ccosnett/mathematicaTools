(* ::Package:: *)

BeginPackage["mathematicaTools`pdfTools`"];
Unprotect["mathematicaTools`pdfTools`*"]; ClearAll["mathematicaTools`pdfTools`*"]; ClearAll["mathematicaTools`pdfTools`Private`*"]; ClearSystemCache[];



Begin["`Private`"];
Needs["mathematicaTools`"];


(* exports the current notebook as a PDF document in the same directory *)
exportCurrentNotebookToPDF:=(
   nb = EvaluationNotebook[];
   nbPath = NotebookFileName[nb];
   pdfPath = FileBaseName[nbPath] <> ".pdf";
   Export[FileNameJoin[{DirectoryName[nbPath], pdfPath}], nb, "PDF"];
   SelectionMove[EvaluationCell[], All, EvaluationCell]; NotebookDelete[];
   SelectionMove[EvaluationNotebook[], Next, CellContents]
);

(* alias *)
end:=exportCurrentNotebookToPDF


End[];
EndPackage[]