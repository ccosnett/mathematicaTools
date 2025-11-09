(*

PacletDirectoryLoad["~/PycharmProjects/mathematica_tools/"];
Get["mathematicaTools`"] // Quiet;
?? mathematicaTools`*

*)

Print["loaded paclet: mathematicaTools"];
(* ::Package:: *)

(* :Title: mathematicaTools *)
(* :Context: mathematicaTools` *)
(* :Authors: Conor Cosnett*)
(* :Date: 2025-11-09 *)


BeginPackage["mathematicaTools`"];
Unprotect["mathematicaTools`*"]; ClearAll["mathematicaTools`*"]; ClearAll["mathematicaTools`Private`*"]; ClearSystemCache[];


(* pdfTools` *)
exportCurrentNotebookToPDF
end




Get["mathematicaTools`pdfTools`"]

EndPackage[];