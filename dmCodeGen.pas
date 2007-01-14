{
wxDialog Designer
Copyright (c) 2003 Guru Kathiresan grk4352@njit.edu
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit dmCodeGen;

interface

uses classes, Sysutils, DbugIntf,xprocs,SciLexer, SciLexerMemo, SciLexerMod;

type
    TBlockType = (btManualCode,btDialogStyle, btHeaderIncludes, btForwardDec, btClassNameControlIdentifiers, btClassNameEnumControlIdentifiers,btXPMImages, btClassNameEventTableEntries, btClassNameGUIItemsCreation, btClassNameGUIItemsDeclaration,btLHSVariables,btRHSVariables);

function GetStartAndEndBlockStrings(ClassNameString: string; blockType: TBlockType; var StartString, EndString: string): Boolean;

{$IFDEF SCINTILLA}
function GetBlockStartAndEndPos(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: Integer): Boolean;

function GetBlockCode(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): TStringList;

function DeleteBlock(synEdit:TScintilla; wxClassName: string; blockType: TBlockType): Boolean;

function AddDialogStyleDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllDialogStyleDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameGUIItemsDeclaration(synEdit:TScintilla;ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllClassNameGUIItemsDeclaration(synEdit:TScintilla;ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameEnumControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameEnumControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameIncludeHeader(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameIncludeHeader(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameEventTableEntries(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; EvtString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllClassNameEventTableEntries(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddRHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllRHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddLHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllLHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function GetBlockStartAndEndPos(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: Integer): Boolean;

//function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): string;overload;
function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): TStringList;

function DeleteBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType): Boolean;

function AddDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameGUIItemsDeclaration(synEdit:TSynEdit;ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllClassNameGUIItemsDeclaration(synEdit:TSynEdit;ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
function DeleteAllClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameIncludeHeader(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
function DeleteAllClassNameIncludeHeader(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; EvtString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;

function AddLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
function DeleteAllLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}


implementation

{$IFDEF SCINTILLA}
function AddHeaderInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ELSE}
function AddHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

{$IFDEF SCINTILLA}
function EditHeaderInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
{$ELSE}
function EditHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
{$ENDIF}
begin
  Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteHeaderInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ELSE}
function DeleteHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function AddSourceInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ELSE}
function AddSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function EditSourceInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
{$ELSE}
function EditSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteSourceInclude(synEdit:TScintilla; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ELSE}
function DeleteSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function AddClassNameControlIdentifier(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
{$ELSE}
function AddClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function EditClassNameControlIdentifier(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; FromIdString, ToIdString: string): Boolean;
{$ELSE}
function EditClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromIdString, ToIdString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteClassNameControlIdentifier(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
{$ELSE}
function DeleteClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function AddXPMImage(synEdit:TScintilla; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
{$ELSE}
function AddXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function EditXPMImage(synEdit:TScintilla; BlockStart, BlockEnd: Integer; FromXPMString, ToXPMString: string): Boolean;
{$ELSE}
function EditXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromXPMString, ToXPMString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteXPMImage(synEdit:TScintilla; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
{$ELSE}
function DeleteXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

{$IFDEF SCINTILLA}
function AddClassNameEventTableEntries(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; EvtString: string;useTabChar:Boolean = true): Boolean;
{$ELSE}
function AddClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; EvtString: string;useTabChar:Boolean = true): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst:TStringList;
    strData:string;
begin
    Result:= True;
    if trim(EvtString) = '' then
        exit;
    strlst:=TStringList.Create;
    strlst.Text:=EvtString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData:=Trim(strlst[i]);
        if useTabChar then
            strData:=#9+strData;

        if strData <> '' then
	    synEdit.Lines.Insert(BlockStart + 1,strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

{$IFDEF SCINTILLA}
function EditClassNameEventTableEntries(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; FromEvtString, ToEvtString: string): Boolean;
{$ELSE}
function EditClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromEvtString, ToEvtString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;


{$IFDEF SCINTILLA}
function DeleteAllClassNameEventTableEntries(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameEventTableEntries);
end;

{$IFDEF SCINTILLA}
function AddRHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
{$ELSE}
function AddRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst:TStringList;
    strData:string;
begin
    Result:= True;
    if trim(VarString) = '' then
        exit;
    strlst:=TStringList.Create;
    strlst.Text:=VarString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData:=Trim(strlst[i]);
        if useTabChar then
            strData:=#9+strData;

        if strData <> '' then
	    synEdit.Lines.Insert(BlockStart + 1,strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

{$IFDEF SCINTILLA}
function DeleteAllRHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btRHSVariables);
end;

{$IFDEF SCINTILLA}
function AddLHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
{$ELSE}
function AddLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst:TStringList;
    strData:string;
begin
    Result:= True;
    if trim(VarString) = '' then
        exit;
    strlst:=TStringList.Create;
    strlst.Text:=VarString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData:=Trim(strlst[i]);
        if useTabChar then
            strData:=#9+strData;

        if strData <> '' then
	    synEdit.Lines.Insert(BlockStart + 1,strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

{$IFDEF SCINTILLA}
function DeleteAllLHSVariableList(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btLHSVariables);
end;

{$IFDEF SCINTILLA}
function AddDialogStyleDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ELSE}
function AddDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst:TStringList;
begin
    Result:= True;
    if trim(GUIItemString) = '' then
        exit;

    strlst:=TStringList.Create;

    strTokenToStrings(GUIItemString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	synEdit.Lines.Insert(BlockStart + 1, Trim(strlst[i]));
    end;    // for

    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;

end;


{$IFDEF SCINTILLA}
function DeleteAllDialogStyleDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btDialogStyle);
end;

{$IFDEF SCINTILLA}
function AddClassNameGUIItemsDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ELSE}
function AddClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst: TStringList;
begin
    Result:= True;
    if trim(GUIItemString) = '' then
        exit;
    strlst:=TStringList.Create;

    strTokenToStrings(GUIItemString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        synEdit.Lines.Insert(BlockStart + 1,#9#9+Trim(strlst[i]));
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
end;

{$IFDEF SCINTILLA}
function EditClassNameGUIItemsDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
{$ELSE}
function EditClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteClassNameGUIItemsDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ELSE}
function DeleteClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteAllClassNameGUIItemsDeclaration(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsDeclaration);
end;


{$IFDEF SCINTILLA}
function AddClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ELSE}
function AddClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst: TStringList;
begin
    Result:= True;
    if trim(GUIItemString) = '' then
        exit;
    strlst:=TStringList.Create;

    strTokenToStrings(GUIItemString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	synEdit.Lines.Insert(BlockStart + 1,#9 + Trim(strlst[i]));
    end;    // for
    synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;

end;

{$IFDEF SCINTILLA}
function EditClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
{$ELSE}
function EditClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
{$ENDIF}
begin
  Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ELSE}
function DeleteClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteAllClassNameGUIItemsCreation(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsCreation);
end;


{$IFDEF SCINTILLA}
function AddClassNameControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ELSE}
function AddClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst: TStringList;
begin
    Result:= True;
    if trim(ControlIDString) = '' then
        exit;
    strlst:=TStringList.Create;

    strTokenToStrings(ControlIDString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	synEdit.Lines.Insert(BlockStart + 1,Trim(strlst[i]));
    end;    // for

    strlst.Destroy;
end;

{$IFDEF SCINTILLA}
function EditClassNameControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; FromControlIDString, ToControlIDString: string): Boolean;
{$ELSE}
function EditClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromControlIDString, ToControlIDString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

{$IFDEF SCINTILLA}
function DeleteAllClassNameControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameControlIdentifiers);
end;

{$IFDEF SCINTILLA}
function AddClassNameEnumControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ELSE}
function AddClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst: TStringList;
begin
    Result:= True;
    if trim(ControlIDString) = '' then
        exit;
    strlst:=TStringList.Create;

    strTokenToStrings(ControlIDString,#13,strlst);

    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	synEdit.Lines.Insert(BlockStart + 1, #9#9#9 + Trim(strlst[i]));
    end;    // for

    strlst.Destroy;
end;

{$IFDEF SCINTILLA}
function DeleteAllClassNameEnumControlIndentifiers(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameEnumControlIdentifiers);
end;

{$IFDEF SCINTILLA}
function AddClassNameIncludeHeader(synEdit:TScintilla;ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ELSE}
function AddClassNameIncludeHeader(synEdit:TSynEdit;ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
{$ENDIF}
var
    i:Integer;
    strlst: TStringList;
begin
    Result:= True;
    if trim(ControlIDString) = '' then
        exit;
    strlst:=TStringList.Create;

    strTokenToStrings(ControlIDString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	synEdit.Lines.Insert(BlockStart + 1,Trim(strlst[i]));
    end;    // for

    strlst.Destroy;

end;

{$IFDEF SCINTILLA}
function DeleteAllClassNameIncludeHeader(synEdit:TScintilla; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ELSE}
function DeleteAllClassNameIncludeHeader(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
{$ENDIF}
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btHeaderIncludes);
end;

function GetStartAndEndBlockStrings(ClassNameString: string; blockType: TBlockType; var StartString, EndString: string): Boolean;
begin

    Result:= True;

    StartString := '';
    EndString := '';

    if blockType = btManualCode then
    begin
        StartString := '////Manual Code Start';
        EndString := '////Manual Code End';
        Exit;
    end;

    if blockType = btDialogStyle then
    begin
        StartString := '////Dialog Style Start';
        EndString := '////Dialog Style End';
        Exit;
    end;


    if blockType = btHeaderIncludes then
    begin
        StartString := '////Header Include Start';
        EndString := '////Header Include End';
        Exit;
    end;

    if blockType = btClassNameControlIdentifiers then
    begin
        StartString := '////GUI Control ID Start';
        EndString := '////GUI Control ID End';
        Exit;
    end;

    if blockType = btClassNameEnumControlIdentifiers then
    begin
        StartString := '////GUI Enum Control ID Start';
        EndString := '////GUI Enum Control ID End';
        Exit;
    end;

    if blockType = btXPMImages then
    begin
        StartString := '////@begin XPM images';
        EndString := '////@end XPM images';
        Exit;
    end;

    if blockType = btClassNameEventTableEntries then
    begin
        StartString := '////Event Table Start';
        EndString := '////Event Table End';
        Exit;
    end;


    if blockType = btClassNameGUIItemsCreation then
    begin
        StartString := '////GUI Items Creation Start';
        EndString := '////GUI Items Creation End';
        Exit;
    end;

    if blockType = btClassNameGUIItemsDeclaration then
    begin
        StartString := '////GUI Control Declaration Start';
        EndString := '////GUI Control Declaration End';
        Exit;
    end;

    if blockType = btRHSVariables then
    begin
        StartString := '////RHS Variables Start';
        EndString := '////RHS Variables End';
        Exit;
    end;

    if blockType = btLHSVariables then
    begin
        StartString := '////LHS Variables Start';
        EndString := '////LHS Variables End';
        Exit;
    end;
    
end;

function GetBlockStartString(ClassNameString: string; blockType: TBlockType): string;
var
    StartString, EndString: string;
begin
    GetStartAndEndBlockStrings(ClassNameString, blockType, StartString, EndString);
    Result := StartString;
end;

function GetBlockEndString(ClassNameString: string; blockType: TBlockType): string;
var
    StartString, EndString: string;
begin
    GetStartAndEndBlockStrings(ClassNameString, blockType, StartString, EndString);
    Result := EndString;
end;



{$IFDEF SCINTILLA}
function GetBlockStartAndEndPos(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: Integer): Boolean;
{$ELSE}
function GetBlockStartAndEndPos(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: Integer): Boolean;
{$ENDIF}
var
    strStartBlock, strEndBlock: string;
    i: Integer;
    strLine: string;
begin
    Result := true;

    StartPos := 0;
    EndPos := 0;

    strStartBlock := trim(GetBlockStartString(wxClassName, blockType));
    strEndBlock := trim(GetBlockEndString(wxClassName, blockType));

    if (strStartBlock = '') or (strEndBlock = '') then
    begin
        Result := false;
        exit;
    end;

    for i := 0 to synEdit.Lines.count - 1 do
    begin
        strLine := synEdit.Lines[i];
        if UpperCase(trim(strLine)) = UpperCase(strStartBlock) then
        begin
            if StartPos <> 0 then
            begin
                Result := false;
                exit;
            end;
            StartPos := i;
            continue;
        end;

        if UpperCase(trim(strLine)) = UpperCase(strEndBlock) then
        begin
            if EndPos <> 0 then
            begin
                Result := false;
                exit;
            end;
            EndPos := i;
            continue;
        end;

    end;

    if (StartPos = 0) or (EndPos = 0) then
    begin
        Result := false;
        Exit;
    end;

end;
{$IFDEF SCINTILLA}
{$ELSE}
//function GetBlockCode(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): string;
//var
//    strLst:TStringList;
//begin
//    strLst:=TStringList.Create;
//    for i := StartPos+1 to EndPos-1 do
//    begin
//        strLst.add(synEdit.Lines[i]);
//    end;
//    Result:=strLst.Text;
//    strLst.destroy;
//
//end;
{$ENDIF}

{$IFDEF SCINTILLA}
function GetBlockCode(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): TStringList;
{$ELSE}
function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): TStringList;
{$ENDIF}
var
    i:Integer;
begin
    Result:=TStringList.Create;

    try
      for i := StartPos+1 to EndPos-1 do
      begin
         Result.Add(synEdit.Lines[i]);
      end;
    except
      Result.Free;
      raise;
    end;
    
end;


{$IFDEF SCINTILLA}
function DeleteBlock(synEdit:TScintilla; wxClassName: string; blockType: TBlockType): Boolean;
{$ELSE}
function DeleteBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType): Boolean;
{$ENDIF}
var
    StartLinePos, EndLinePos: Integer;
    i: Integer;
begin
    Result := true;
    StartLinePos := 0;
    EndLinePos := 0;

    if not GetBlockStartAndEndPos(synEdit, wxClassName, blockType, StartLinePos, EndLinePos) then
    begin
        Result := false;
        exit;
    end;

    for i := EndLinePos - 1 downto StartLinePos + 1 do
    begin
        synEdit.Lines.Delete(i);
    end;

end;

{$IFDEF SCINTILLA}
function AddItemToBlock(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
{$ELSE}
function AddItemToBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
{$ENDIF}
begin
    Result:= True;
end;

//function AddItemToBlock(SourceLines:TStringList;intBlockStart,intBlockEnd:Integer;StartblkString:String):Boolean;overload;
//begin
//
//End;

{$IFDEF SCINTILLA}
function LocateLineInBlock(synEdit:TScintilla; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
{$ELSE}
function LocateLineInBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
{$ENDIF}
begin
Result:= True;
end;

//function LocateLineInBlock(SourceLines:TStringList,intBlockStart,intBlockEnd:Integer;LineString:String):Boolean;
//Begin
////
//ENd;


function ChangeClassName(FromClassName, ToClassName: string): Boolean;
begin
    Result:= True;
end;


end.
