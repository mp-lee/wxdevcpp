unit LanguagesDEPfix;

{ Patch for Data Execution Prevention (DEP) problems with SysUtils.TLanguages. }
{ In the Delphi RTL the TLanguages constructor dynamically builds and executes }
{ machine code in the stack segment without setting the PAGE_EXECUTE_READWRITE }
{ or PAGE_EXECUTE_WRITECOPY bits. It appears that that code doesn't run on     }
{ systems that have DEP enabled - e.g. WinXP SP2, Win2003 SP1. Note that       }
{ Win2003 SP1 has DEP activated by default.                                    }
{ This problem is fixed in the Delphi 2005 RTL.                                }
{                                                                              }
{ Usage:                                                                       }
{ Put this unit as the first unit in the uses clause of the source of the      }
{ project. At least make sure this unit is listed *before* the first SysUtils. }
{ Tested with D5, D6 and D7.                                                   }
{                                                                              }
{ Author: Sasan Adami - s.adami@gmx.net                                        }
{ Date  : 20 july 2005                                                         }
{ Disclaimer: use at your own risk!                                            }

{$WARN SYMBOL_PLATFORM OFF}
interface

uses
    Windows, Classes;

implementation

uses
    SysUtils, SysConst;

type
    PJumpRec = ^TJumpRec;
    TJumpRec = packed record
        OpCode: byte;
        Address: DWord;
    end;

    PLongJumpRec = ^TLongJumpRec;
    TLongJumpRec = packed record
        OpCode: word;
        Address: DWord;
    end;

    // hack for access to private members of TLanguage
    THackLanguages = class
    private
        FSysLangs: array of TLangRec;
    end;

    // replacement for TLanguages.Create
    TLanguagesDEPfix = class(TLanguages)
    private
        function LocalesCallback(LocaleID: pchar): integer; stdcall;
    public
        constructor Create;
    end;

var
    FTempLanguages: TLanguagesDEPfix;

function EnumLocalesCallback(LocaleID: pchar): integer; stdcall;
begin
    Result := FTempLanguages.LocalesCallback(LocaleID);
end;

function GetLocaleDataW(ID: LCID; Flag: DWORD): string;
var
    Buffer: array[0..1023] of widechar;
begin
    Buffer[0] := #0;
    GetLocaleInfoW(ID, Flag, Buffer, SizeOf(Buffer) div 2);
    Result := Buffer;
end;

function GetLocaleDataA(ID: LCID; Flag: DWORD): string;
var
    Buffer: array[0..1023] of char;
begin
    Buffer[0] := #0;
    SetString(Result, Buffer, GetLocaleInfoA(ID, Flag, Buffer,
        SizeOf(Buffer)) - 1);
end;

{ TLanguagesDEPfix }

function TLanguagesDEPfix.LocalesCallback(LocaleID: pchar): integer; stdcall;
type
    PSysLangs = ^TSysLangs;
    TSysLangs = array of TLangRec;
var
    AID: LCID;
    ShortLangName: string;
    GetLocaleDataProc: function(ID: LCID; Flag: DWORD): string;
    PSLangs: PSysLangs;
begin
    if Win32Platform = VER_PLATFORM_WIN32_NT then
        GetLocaleDataProc := @GetLocaleDataW
    else
        GetLocaleDataProc := @GetLocaleDataA;
    AID := StrToInt('$' + Copy(LocaleID, 5, 4));
    ShortLangName := GetLocaleDataProc(AID, LOCALE_SABBREVLANGNAME);
    if ShortLangName <> '' then
    begin
        PSLangs := @THackLanguages(Self).FSysLangs;
        SetLength(PSLangs^, Length(PSLangs^) + 1);
        with PSLangs^[High(PSLangs^)] do
        begin
            FName := GetLocaleDataProc(AID, LOCALE_SLANGUAGE);
            FLCID := AID;
            FExt := ShortLangName;
        end;
    end;
    Result := 1;
end;

constructor TLanguagesDEPfix.Create;
begin
    FTempLanguages := Self;
    EnumSystemLocales(@EnumLocalesCallback, LCID_SUPPORTED);
end;

var
    FLanguages: TLanguagesDEPfix;

function Languages: TLanguages;
begin
    if FLanguages = NIL then
        FLanguages := TLanguagesDEPfix.Create;
    Result := FLanguages;
end;

procedure ApplyLanguagesDEPfix;
var
    JumpRec: PJumpRec;
    LongJumpRec: PLongJumpRec;
    OldProtect: DWord;
    IsPackages: boolean;
begin
    JumpRec := PJumpRec(@SysUtils.Languages);
    LongJumpRec := Pointer(JumpRec);

    IsPackages := LongJumpRec.OpCode = $25FF; // runtime package?
    if IsPackages then
        JumpRec := Pointer(PDWord(LongJumpRec.Address)^);

    if not VirtualProtect(JumpRec, SizeOf(JumpRec^),
        PAGE_EXECUTE_WRITECOPY, @OldProtect) then
        // If we cannot change the access right the following line will crash. Exit here anyway.
        Exit;
    JumpRec.OpCode := $E9; // 32bit jump near
    JumpRec.Address := integer(@Languages) - integer(JumpRec) - 5;
    VirtualProtect(JumpRec, SizeOf(JumpRec^), OldProtect, @OldProtect);
end;

initialization
    ApplyLanguagesDEPfix;

end.
