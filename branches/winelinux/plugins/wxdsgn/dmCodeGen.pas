{
wxDialog Designer
}
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }


unit dmCodeGen;

interface

uses classes, Sysutils, xprocs,synEdit;

type
    TBlockType = (btManualCode,btDialogStyle, btHeaderIncludes, btForwardDec, btClassNameControlIdentifiers, btClassNameEnumControlIdentifiers,btXPMImages, btClassNameEventTableEntries, btClassNameGUIItemsCreation, btClassNameGUIItemsDeclaration,btLHSVariables,btRHSVariables);

function GetStartAndEndBlockStrings(ClassNameString: string; blockType: TBlockType; var StartString, EndString: string): Boolean;

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


implementation

function AddHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
begin
    Result:= True;
end;

function EditHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
begin
  Result:= True;
end;

function DeleteHeaderInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
begin
Result:= True;
end;

function AddSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
begin
Result:= True;
end;

function EditSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromHeaderString, ToHeaderString: string): Boolean;
begin
Result:= True;
end;

function DeleteSourceInclude(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; HeaderString: string): Boolean;
begin
Result:= True;
end;

function AddClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
begin
Result:= True;
end;

function EditClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromIdString, ToIdString: string): Boolean;
begin
Result:= True;
end;

function DeleteClassNameControlIdentifier(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; IdString: string): Boolean;
begin
Result:= True;
end;

function AddXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
begin
Result:= True;
end;

function EditXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; FromXPMString, ToXPMString: string): Boolean;
begin
Result:= True;
end;

function DeleteXPMImage(synEdit:TSynEdit; BlockStart, BlockEnd: Integer; XPMString: string): Boolean;
begin
Result:= True;
end;

function AddClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; EvtString: string;useTabChar:Boolean = true): Boolean;
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

function EditClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromEvtString, ToEvtString: string): Boolean;
begin
Result:= True;
end;


function DeleteAllClassNameEventTableEntries(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameEventTableEntries);
end;

function AddRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
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

function DeleteAllRHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btRHSVariables);
end;

function AddLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; VarString: string;useTabChar:Boolean = true): Boolean;
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

function DeleteAllLHSVariableList(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btLHSVariables);
end;

function AddDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
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


function DeleteAllDialogStyleDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btDialogStyle);
end;

function AddClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
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

function EditClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
begin
    Result:= True;
end;

function DeleteClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
begin
    Result:= True;
end;

function DeleteAllClassNameGUIItemsDeclaration(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsDeclaration);
end;


function AddClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
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

function EditClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromGUIItemString, ToGUIItemString: string): Boolean;
begin
  Result:= True;
end;

function DeleteClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; GUIItemString: string): Boolean;
begin
    Result:= True;
end;

function DeleteAllClassNameGUIItemsCreation(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsCreation);
end;


function AddClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
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

function EditClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; FromControlIDString, ToControlIDString: string): Boolean;
begin
    Result:= True;
end;

function DeleteAllClassNameControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameControlIdentifiers);
end;

function AddClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
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

function DeleteAllClassNameEnumControlIndentifiers(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
begin
    Result:= True;
    DeleteBlock(synEdit, ClassNameString, btClassNameEnumControlIdentifiers);
end;

function AddClassNameIncludeHeader(synEdit:TSynEdit;ClassNameString: string; BlockStart, BlockEnd: Integer; ControlIDString: string): Boolean;
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

function DeleteAllClassNameIncludeHeader(synEdit:TSynEdit; ClassNameString: string; BlockStart, BlockEnd: Integer): Boolean;
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



function GetBlockStartAndEndPos(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: Integer): Boolean;
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
//function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): string;
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

function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): TStringList;
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


function DeleteBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType): Boolean;
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

function AddItemToBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
begin
    Result:= True;
end;

//function AddItemToBlock(SourceLines:TStringList;intBlockStart,intBlockEnd:Integer;StartblkString:String):Boolean;overload;
//begin
//
//End;

function LocateLineInBlock(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): Boolean;
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