#!/usr/local/bin/wolframscript

(*#!/home/conor/mathematica/Executables/wolframscript*)
name="comp";
Get["PacletTools`"];

notebookDirectory[]=Directory[];
dir=ParentDirectory[notebookDirectory[]]<>"/"<>name<>"/build/";
PacletUninstall[name];
DeleteDirectory[directory1 = ParentDirectory[notebookDirectory[]]<>"/"<>name<>"/build/",DeleteContents->True];
directory2=ParentDirectory[notebookDirectory[]]<>"/"<>name;
PacletBuild[directory2];
dir=ParentDirectory[notebookDirectory[]]<>"/"<>name;
PacletInstall[dir<>"/build/"<>name<>"-0.0.1.paclet",ForceVersionInstall->True];


(* Print[ToString[directory1]<>", directory deleted \n\n now...."];
 *)

(*UsingFrontEnd[Get["PacletTools`"]];*)
(*
Print[
    UsingFrontEnd[
    (*Get["PacletTools`"];*)
    directory2=ParentDirectory[notebookDirectory[]]<>"/pol";
    Echo[directory2];
    PacletBuild[directory2];
]
];
*)

(*
Print[directory2];
Echo[PacletBuild[directory2]];
*)
(*

Print[ToString[directory2]<>", paclet built, \n\n now...."];

Print[
UsingFrontEnd[
dir=ParentDirectory[notebookDirectory[]]<>"/pol";
PacletInstall[dir<>"/build/pol-0.0.1.paclet",ForceVersionInstall->True];
]
];

*)


Get["comp`"];
