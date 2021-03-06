{
    $Id: version.pas 845 2007-01-20 08:23:50Z gururamnath $

    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit version;

interface

uses xprocs, SysUtils, Registry, Windows, Classes, utils, Dialogs;

var
    LIB_EXT: string;
    OBJ_EXT: string;
    PCH_EXT: string;
    COMMON_CPP_INCLUDE_DIR: string;

const
    //path delimiter
{$IFDEF WIN32}
    pd = '\';
{$ENDIF}
{$IFDEF LINUX}
  pd                   = '/';
{$ENDIF}

resourcestring
    // misc strings
    DEVCPP = 'wxDev-C++';
    DEVCPP_WEBPAGE = 'http://wxdsgn.sourceforge.net/';
    DEFAULT_LANG_FILE = 'English.lng';
    HTTP = 'http://';
    DEV_INTERNAL_OPEN = '$__DEV_INTERNAL_OPEN';
    DEV_SEARCHLOOP = '$__DEV_SEARCH_LOOP';
    DEV_COMPLETION_CACHE = 'cache.ccc';
    DEV_DEFAULTCODE_FILE = 'defaultcode.cfg';
    DEV_SHORTCUTS_FILE = 'devshortcuts.cfg';
    DEV_CLASSFOLDERS_FILE = 'classfolders.dcf';
    DEV_WEBMIRRORS_FILE = 'mirrors.cfg';
    DEV_MAKE_FILE = 'Makefile.win';
    DEV_TOOLS_FILE = 'tools.ini';
    DEV_HELP_INI = 'devhelp.ini';
    DEV_CODEINS_FILE = 'devcpp.ci';
    DEV_MAINHELP_FILE = 'devcpp.chm';
    DEV_GNOME_THEME = 'Gnome';
    DEV_NEWLOOK_THEME = 'New Look';
    DEV_BLUE_THEME = 'Blue';
    DEV_CLASSIC_THEME = 'Classic';
    DEV_INTERNAL_THEME = 'New Look';

    // default directories
    GCC_BIN_DIR = 'bin;';
    GCC_LIB_DIR = 'lib;lib' + pd + 'wx' + pd + 'gcc_lib;';
    GCC_C_INCLUDE_DIR = 'include;';
    GCC_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Vc++
    VC2010_BIN_DIR = 'bin' + pd + 'VC2010;bin;';
    VC2010_LIB_DIR = 'lib;lib' + pd + 'wx' + pd + 'vc_lib;';
    VC2010_C_INCLUDE_DIR = 'include' + pd + 'common;include' + pd + 'VC2010;';
    VC2010_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2008_BIN_DIR = 'Bin' + pd + 'VC2008;Bin;';
    VC2008_LIB_DIR = 'Lib' + pd + 'VC2008';
    VC2008_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2008;';
    VC2008_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2005_BIN_DIR = 'Bin' + pd + 'VC2005;Bin;';
    VC2005_LIB_DIR = 'Lib' + pd + 'VC2005';
    VC2005_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2005;';
    VC2005_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2003_BIN_DIR = 'Bin' + pd + 'VC2003;Bin;';
    VC2003_LIB_DIR = 'Lib' + pd + 'VC2003;';
    VC2003_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2003;';
    VC2003_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC6_BIN_DIR = 'Bin' + pd + 'VC6;Bin;';
    VC6_LIB_DIR = 'Lib' + pd + 'VC6;';
    VC6_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC6;';
    VC6_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //DMAR
    DMARS_BIN_DIR = 'Bin;Bin' + pd + 'dmars;';
    DMARS_LIB_DIR = 'Lib' + pd + 'dmars;';
    DMARS_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'dmars;';
    DMARS_RC_INCLUDE_DIR =
        'include' + pd + 'common;' + ';include' + pd + 'dmars' + pd + 'include;' +
        ';include' + pd + 'dmars' + pd + 'include' + pd + 'win32;';

    //Borland
    BORLAND_BIN_DIR = 'Bin;Bin' + pd + 'borland;';
    BORLAND_LIB_DIR = 'Lib' + pd + 'borland;';
    BORLAND_C_INCLUDE_DIR = 'Include' + pd + 'borland;Include' + pd + 'common;';
    BORLAND_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Borland
    WATCOM_BIN_DIR = 'Bin;Bin' + pd + 'watcom;';
    WATCOM_LIB_DIR = 'Lib' + pd + 'watcom;';
    WATCOM_C_INCLUDE_DIR = 'Include' + pd + 'watcom;Include' + pd + 'common;';
    WATCOM_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Wine/Linux
    LINUX_BIN_DIR = '\bin;\usr\bin';
    LINUX_LIB_DIR = '\usr\lib';
    LINUX_C_INCLUDE_DIR = '\usr\include';
    LINUX_RC_INCLUDE_DIR = '';

    GCC_CPP_INCLUDE_DIR = ';include';

    VC2010_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2010;' + 'include' + pd + 'common;';

    VC2008_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2008;' + 'include' + pd + 'common;';

    VC2005_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2005;' + 'include' + pd + 'common;';

    VC2003_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2003;' + 'include' + pd + 'common;';

    VC6_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC6;' + 'include' + pd + 'common;';
    BORLAND_CPP_INCLUDE_DIR =
        ';include' + pd + 'borland;' + 'include' + pd + 'common;';

    DMARS_CPP_INCLUDE_DIR =
        ';include' + pd + 'dmars' + pd + 'include;' +
        ';include' + pd + 'dmars' + pd + 'include' + pd + 'win32;' +
        ';include' + pd + 'common;' + ';include' + pd + 'dmars' + pd + 'stlport' + pd + 'stlport;';

    WATCOM_CPP_INCLUDE_DIR =
        ';include' + pd + 'watcom;' + 'include' + pd + 'common;';

    LINUX_CPP_INCLUDE_DIR = '';

    LANGUAGE_DIR = 'Lang' + pd;
    ICON_DIR = 'Icons' + pd;
    HELP_DIR = 'Help' + pd;
    TEMPLATE_DIR = 'Templates' + pd;
    THEME_DIR = 'Themes' + pd;
    PACKAGES_DIR = 'Packages' + pd;

    // file fxtensions
    DLL_EXT = '.dll';
    EXE_EXT = '.exe';
    DEV_EXT = '.dev';
    HTML_EXT = '.html';
    RTF_EXT = '.rtf';
    INI_EXT = '.ini';
    TEMPLATE_EXT = '.template';
    SYNTAX_EXT = '.syntax';

    // programs
    PACKMAN_PROGRAM = 'packman.exe';
    UPDATE_PROGRAM = 'updater.exe';

    GCC_MAKE_PROGRAM = 'mingw32-make.exe';
    GCC_CP_PROGRAM = 'gcc.exe';
    GCC_CPP_PROGRAM = 'g++.exe';
    GCC_DBG_PROGRAM = 'gdb.exe';
    GCC_RES_PROGRAM = 'windres.exe';
    GCC_DLL_PROGRAM = 'dllwrap.exe';
    GCC_PROF_PROGRAM = 'gprof.exe';
    GCC_COMPILER_CMD_LINE = '';
    GCC_LINKER_CMD_LINE = '';
    GCC_MAKE_CMD_LINE = '';

    VC_MAKE_PROGRAM = 'mingw32-make.exe';
    VC_CP_PROGRAM = 'cl.exe';
    VC_CPP_PROGRAM = 'cl.exe';
    VC_DBG_PROGRAM = 'cdb.exe';
    VC_RES_PROGRAM = 'rc.exe';
    VC_DLL_PROGRAM = 'link.exe';
    VC_PROF_PROGRAM = 'mt.exe';
    VC_COMPILER_CMD_LINE = '';
    VC_LINKER_CMD_LINE = '';
    VC_MAKE_CMD_LINE = '';

    DMARS_MAKE_PROGRAM = 'mingw32-make.exe';
    DMARS_CP_PROGRAM = 'dmc.exe';
    DMARS_CPP_PROGRAM = 'dmc.exe';
    DMARS_DBG_PROGRAM = 'cdb.exe';
    DMARS_RES_PROGRAM = 'rcc.exe';
    DMARS_DLL_PROGRAM = 'link.exe';
    DMARS_PROF_PROGRAM = '';
    DMARS_COMPILER_CMD_LINE = '-D_STLP_NO_NEW_IOSTREAMS';
    DMARS_LINKER_CMD_LINE = '';
    DMARS_MAKE_CMD_LINE = '';

    BORLAND_MAKE_PROGRAM = 'mingw32-make.exe';
    BORLAND_CP_PROGRAM = 'borgcc.exe';
    BORLAND_CPP_PROGRAM = 'borg++.exe';
    BORLAND_DBG_PROGRAM = 'borgdb.exe';
    BORLAND_RES_PROGRAM = 'borwindres.exe';
    BORLAND_DLL_PROGRAM = 'link.exe';
    BORLAND_PROF_PROGRAM = 'borgprof.exe';
    BORLAND_COMPILER_CMD_LINE = '';
    BORLAND_LINKER_CMD_LINE = '';
    BORLAND_MAKE_CMD_LINE = '';

    WATCOM_MAKE_PROGRAM = 'mingw32-make.exe';
    WATCOM_CP_PROGRAM = 'owatgcc.exe';
    WATCOM_CPP_PROGRAM = 'owatg++.exe';
    WATCOM_DBG_PROGRAM = 'owatgdb.exe';
    WATCOM_RES_PROGRAM = 'owatwindres.exe';
    WATCOM_DLL_PROGRAM = 'link.exe';
    WATCOM_PROF_PROGRAM = 'owatgprof.exe';
    WATCOM_COMPILER_CMD_LINE = '';
    WATCOM_LINKER_CMD_LINE = '';
    WATCOM_MAKE_CMD_LINE = '';

    LINUX_MAKE_PROGRAM = '/usr/bin/make';
    LINUX_CP_PROGRAM = 'gcc';
    LINUX_CPP_PROGRAM = 'gcc';
    LINUX_DBG_PROGRAM = 'gdb';
    LINUX_RES_PROGRAM = '';
    LINUX_DLL_PROGRAM = 'gcc';
    LINUX_PROF_PROGRAM = 'gprof';
    LINUX_COMPILER_CMD_LINE = '';
    LINUX_LINKER_CMD_LINE = '';
    LINUX_MAKE_CMD_LINE = '';

    // GDB commands and Displays
    GDB_FILE = 'file';
    GDB_EXECFILE = 'exec-file';
    GDB_RUN = 'run';
    GDB_BREAK = 'break';
    GDB_CONTINUE = 'continue';
    GDB_NEXT = 'next';
    GDB_STEP = 'step';
    GDB_DISPLAY = 'display';
    GDB_UNDISPLAY = 'undisplay';
    GDB_PRINT = 'print';
    GDB_SETVAR = 'set var';
    GDB_DELETE = 'delete';
    GDB_PROMPT = '(gdb) ';
    GDB_BACKTRACE = 'bt';
    GDB_DISASSEMBLE = 'disas';
    GDB_SETFLAVOR = 'set disassembly-flavor';
    GDB_INTEL = 'intel';
    GDB_ATT = 'att';
    GDB_REG = 'displ/x';
    GDB_EAX = '$eax';
    GDB_EBX = '$ebx';
    GDB_ECX = '$ecx';
    GDB_EDX = '$edx';
    GDB_ESI = '$esi';
    GDB_EDI = '$edi';
    GDB_EBP = '$ebp';
    GDB_ESP = '$esp';
    GDB_EIP = '$eip';
    GDB_CS = '$cs';
    GDB_DS = '$ds';
    GDB_SS = '$ss';
    GDB_ES = '$es';
    GDB_SETARGS = 'set args';
    GDB_ATTACH = 'attach';
    GDB_SET = 'set';

    // option sections
    OPT_DIRS = 'Directories';
    OPT_EDITOR = 'Editor';
    OPT_HISTORY = 'History';
    OPT_OPTIONS = 'Options';
    OPT_POS = 'Positions';
    OPT_START = 'Startup';
    OPT_COMPILERSETS = 'CompilerSets';
    WEBUPDATE_SECTION = 'WEBUPDATE';

    GCC_DEFCOMPILERSET = 'Default GCC compiler';
    VC2010_DEFCOMPILERSET = 'Default VC2010 compiler';
    VC2008_DEFCOMPILERSET = 'Default VC2008 compiler';
    VC2005_DEFCOMPILERSET = 'Default VC2005 compiler';
    VC2003_DEFCOMPILERSET = 'Default VC2003 compiler';
    VC6_DEFCOMPILERSET = 'Default VC6 compiler';
    DMARS_DEFCOMPILERSET = 'Default DigitalMars compiler';
    BORLAND_DEFCOMPILERSET = 'Default Borland compiler';
    WATCOM_DEFCOMPILERSET = 'Default Watcom compiler';
    LINUX_DEFCOMPILERSET = 'Default Linux gcc compiler';

    //Filters
    FLT_BASE = 'All known Files||';
    FLT_ALLFILES = 'All files (*.*)|*.*|';
    FLT_PROJECTS = 'Dev-C++ project (*.dev)|*.dev';
    FLT_HEADS = 'Header files (*.h;*.hpp;*.rh;*.hh)|*.h;*.hpp;*.rh;*.hh';
    FLT_CS = 'C source files (*.c)|*.c';
    FLT_CPPS =
        'C++ source files (*.cpp;*.cc;*.cxx;*.c++;*.cp)|*.cpp;*.cc;*.cxx;*.c++;*.cp';
    FLT_RES = 'Resource scripts (*.rc)|*.rc';
    FLT_HELPS =
        'Help files (*.hlp;*.chm;*.col)|*.hlp;*.chm;*.col|HTML files (*.htm;*.html)|*.htm;*.html|Text files (*.doc;*.rtf;*.txt)|*.doc;*.rtf;*.txt|All files (*.*)|*.*';
    FLT_MSVCPROJECTS = 'MS Visual C++ projects (*.dsp)|*.dsp';

    cBP = 'Break points';
    cErr = 'Error Line';
    cABP = 'Active Breakpoints';
    cGut = 'Gutter';
    cSel = 'Selected text';

    COMPILER_INI_LABEL = 'CompilerSettings';
    CPP_INI_LABEL = 'CppCompiler';
    C_INI_LABEL = 'Compiler';
    LINKER_INI_LABEL = 'Linker';
    PREPROC_INI_LABEL = 'PreprocDefines';


const
    //  source file extensions
    C_EXT = '.c';
    CPP_EXT = '.cpp';
    CC_EXT = '.cc';
    CXX_EXT = '.cxx';
    CP2_EXT = '.c++';
    CP_EXT = '.cp';
    H_EXT = '.h';
    HPP_EXT = '.hpp';
    RC_EXT = '.rc';
    RES_EXT = '.res';
    RH_EXT = '.rh';
    PATH_LEN = 16384;
    CONFIG_PARAM = '-c';

    // file type arrays used in getfileex in utils
    cTypes: array[0..0] of string[4] = (C_EXT);
    cppTypes: array[0..4] of string[4] =
        (CPP_EXT, CC_EXT, CXX_EXT, CP2_EXT, CP_EXT);
    headTypes: array[0..2] of string[4] = (H_EXT, HPP_EXT, RH_EXT);
    resTypes: array[0..2] of string[4] = (RES_EXT, RC_EXT, RH_EXT);

    // GPROF commands and displays
    GPROF_CHECKFILE = 'gmon.out';
    GPROF_CMD_GENFLAT = '-p';
    GPROF_CMD_GENMAP = '-q';

function DEVCPP_VERSION: string;
function MAKE_PROGRAM(CompilerID: integer): string;
function CP_PROGRAM(CompilerID: integer): string;
function CPP_PROGRAM(CompilerID: integer): string;
function DBG_PROGRAM(CompilerID: integer): string;
function RES_PROGRAM(CompilerID: integer): string;
function DLL_PROGRAM(CompilerID: integer): string;
function PROF_PROGRAM(CompilerID: integer): string;
function DEFCOMPILERSET(CompilerID: integer): string;
function COMPILER_CMD_LINE(CompilerID: integer): string;
function LINKER_CMD_LINE(CompilerID: integer): string;
function MAKE_CMD_LINE(CompilerID: integer): string;
// default directories
function BIN_DIR(CompilerID: integer): string;
function LIB_DIR(CompilerID: integer): string;
function C_INCLUDE_DIR(CompilerID: integer): string;
function CPP_INCLUDE_DIR(CompilerID: integer): string;
function RC_INCLUDE_DIR(CompilerID: integer): string;

function GetRefinedPathList(StrPathValue, strVSInstallPath,
    strVCPPInstallPath, strFSDKInstallDir, strWinSDKPath: string): string;
function GetVC200XPath(versionString: string; PathType: integer): string;
function GetVC6Path(PathType: integer): string;
function GetVC2010Include: string;
function GetVC2008Include: string;
// EAB Comment: Is that OK to keep adding functions for each new compiler? Wouldn't it be better to have something more flexible like config files?
function GetVC2005Include: string;
function GetVC2003Include: string;
function GetVC6Include: string;
function GetVC2010Bin: string;
function GetVC2008Bin: string;
function GetVC2005Bin: string;
function GetVC2003Bin: string;
function GetVC6Bin: string;
function GetVC2010Lib: string;
function GetVC2008Lib: string;
function GetVC2005Lib: string;
function GetVC2003Lib: string;
function GetVC6Lib: string;
function GetTDMGCCDir: string;

var
    DevCppDir: string;

implementation
uses devcfg;

function DEVCPP_VERSION: string;
var
    verblock: PVSFIXEDFILEINFO;
    versionMS, versionLS: cardinal;
    verlen: cardinal;
    rs: TResourceStream;
    m: TMemoryStream;
    p: pointer;
    s: cardinal;
    AppVersionString: string;
begin
    m := TMemoryStream.Create;
    try
        rs := TResourceStream.CreateFromID(HInstance, 1, RT_VERSION);
        try
            m.CopyFrom(rs, rs.Size);
        finally
            rs.Free;
        end;
        m.Position := 0;
        if VerQueryValue(m.Memory, '\', pointer(verblock), verlen) then
        begin
            VersionMS := verblock.dwFileVersionMS;
            VersionLS := verblock.dwFileVersionLS;
            AppVersionString :=
                IntToStr(versionMS shr 16) + '.' +
                IntToStr(versionMS and $FFFF) + '.' +
                IntToStr(VersionLS shr 16) + '.' +
                IntToStr(VersionLS and $FFFF);
        end;
        if VerQueryValue(m.Memory, pchar('\\StringFileInfo\\' +
            IntToHex(GetThreadLocale, 4) + IntToHex(GetACP, 4) +
            '\\FileDescription'), p, s) or
            VerQueryValue(m.Memory, '\\StringFileInfo\\040904E4\\FileDescription',
            p, s) then //en-us
            AppVersionString := pchar(p) + ' ' + AppVersionString;
    finally
        m.Free;
    end;
    Result := AppVersionString;
end;

function GetProgramFilesDir: string;
var
    TempString: string;
    reg: TRegistry;
begin
    reg := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    try
        TempString := '\Software\Microsoft\Windows\CurrentVersion';
        if (reg.OpenKey(TempString, FALSE) = FALSE) then
            Result := 'C:\Program Files'
        else
        begin
            Result := reg.ReadString('ProgramFilesDir');
            reg.CloseKey;
        end;
    finally
        reg.Free;
    end;
end;

function MAKE_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_MAKE_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_MAKE_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_MAKE_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_MAKE_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_MAKE_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_MAKE_PROGRAM;

    end;

end;

function CP_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_CP_PROGRAM;

        //ID_COMPILER_VC2008:
        //    Result := '"' + StringReplace(GetProgramFilesDir, '\', '/', [rfReplaceAll]) + '/Microsoft Visual Studio 9.0/VC/Bin/' + VC_CP_PROGRAM + '"';

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_CP_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_CP_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_CP_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_CP_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_CP_PROGRAM;

    end;
end;

function CPP_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_CPP_PROGRAM;

        //ID_COMPILER_VC2008:
        //    Result := '"' + StringReplace(GetProgramFilesDir, '\', '/', [rfReplaceAll]) + '/Microsoft Visual Studio 9.0/VC/Bin/' + VC_CPP_PROGRAM + '"';

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_CPP_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_CPP_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_CPP_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_CPP_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_CPP_PROGRAM;

    end;
end;


function DBG_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_DBG_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008:
            if DirectoryExists(GetProgramFilesDir +
                '\Debugging Tools for Windows (x86)') then
                Result := GetProgramFilesDir +
                    '\Debugging Tools for Windows (x86)\' + VC_DBG_PROGRAM
            else
                Result := GetProgramFilesDir + '\Debugging Tools for Windows\' +
                    VC_DBG_PROGRAM;

        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_DBG_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_DBG_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DBG_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DBG_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_DBG_PROGRAM;

    end;
end;

function RES_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_RES_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_RES_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_RES_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_RES_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_RES_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_RES_PROGRAM;
    end;
end;

function DLL_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_DLL_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_DLL_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_DLL_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DLL_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DLL_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_DLL_PROGRAM;
    end;
end;

function DEFCOMPILERSET(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_DEFCOMPILERSET;

        ID_COMPILER_VC2010:
            Result := VC2010_DEFCOMPILERSET;

        ID_COMPILER_VC2008:
            Result := VC2008_DEFCOMPILERSET;

        ID_COMPILER_VC2005:
            Result := VC2005_DEFCOMPILERSET;

        ID_COMPILER_VC2003:
            Result := VC2003_DEFCOMPILERSET;

        ID_COMPILER_VC6:
            Result := VC6_DEFCOMPILERSET;

        ID_COMPILER_DMARS:
            Result := DMARS_DEFCOMPILERSET;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DEFCOMPILERSET;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DEFCOMPILERSET;

        ID_COMPILER_LINUX:
            Result := LINUX_DEFCOMPILERSET;
    end;
end;

function COMPILER_CMD_LINE(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_COMPILER_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_COMPILER_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_COMPILER_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_COMPILER_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_COMPILER_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_COMPILER_CMD_LINE;
    end;
end;

function LINKER_CMD_LINE(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_LINKER_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_LINKER_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_LINKER_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_LINKER_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_LINKER_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_LINKER_CMD_LINE;
    end;
end;

function MAKE_CMD_LINE(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_MAKE_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_MAKE_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_MAKE_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_MAKE_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_MAKE_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_MAKE_CMD_LINE;
    end;
end;

function PROF_PROGRAM(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_PROF_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_PROF_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_PROF_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_PROF_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_PROF_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_PROF_PROGRAM;
    end;
end;

function BIN_DIR(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:

        begin
            Result := GetTDMGCCDir;
            if (Result = '') then
                Result := GCC_BIN_DIR
            else
                Result := Result + pd + 'bin';

        end;

        ID_COMPILER_VC2010:
            Result := VC2010_BIN_DIR + GetVC2010Bin;

        ID_COMPILER_VC2008:
            Result := VC2008_BIN_DIR + GetVC2008Bin;

        ID_COMPILER_VC2005:
            Result := VC2005_BIN_DIR + GetVC2005Bin;

        ID_COMPILER_VC2003:
            Result := VC2003_BIN_DIR + GetVC2003Bin;

        ID_COMPILER_VC6:
            Result := VC6_BIN_DIR + GetVC6Bin;

        ID_COMPILER_DMARS:
            Result := DMARS_BIN_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_BIN_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_BIN_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_BIN_DIR;
    end;
end;

function LIB_DIR(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:

        begin
            Result := GetTDMGCCDir;
            if (Result = '') then
                Result := GCC_LIB_DIR
            else
                Result := Result + pd + 'lib;' + GCC_LIB_DIR;
        end;

        ID_COMPILER_VC2010:
            Result := VC2010_LIB_DIR + GetVC2010Lib;

        ID_COMPILER_VC2008:
            Result := VC2008_LIB_DIR + GetVC2008Lib;

        ID_COMPILER_VC2005:
            Result := VC2005_LIB_DIR + GetVC2005Lib;

        ID_COMPILER_VC2003:
            Result := VC2003_LIB_DIR + GetVC2003Lib;

        ID_COMPILER_VC6:
            Result := VC6_LIB_DIR + GetVC6Lib;

        ID_COMPILER_DMARS:
            Result := DMARS_LIB_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_LIB_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_LIB_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_LIB_DIR;
    end;
end;

function C_INCLUDE_DIR(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:

        begin
            Result := GetTDMGCCDir;
            if (Result = '') then
                Result := GCC_C_INCLUDE_DIR
            else
                Result := Result + pd + 'include';

        end;

        ID_COMPILER_VC2010:
            Result := COMMON_CPP_INCLUDE_DIR + VC2010_C_INCLUDE_DIR +
                GetVC2010Include;

        ID_COMPILER_VC2008:
            Result := COMMON_CPP_INCLUDE_DIR + VC2008_C_INCLUDE_DIR +
                GetVC2008Include;

        ID_COMPILER_VC2005:
            Result := COMMON_CPP_INCLUDE_DIR + VC2005_C_INCLUDE_DIR +
                GetVC2005Include;

        ID_COMPILER_VC2003:
            Result := COMMON_CPP_INCLUDE_DIR + VC2003_C_INCLUDE_DIR +
                GetVC2003Include;

        ID_COMPILER_VC6:
            Result := COMMON_CPP_INCLUDE_DIR + VC6_C_INCLUDE_DIR + GetVC6Include;

        ID_COMPILER_DMARS:
            Result := DMARS_C_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_C_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_C_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_C_INCLUDE_DIR;
    end;
end;

function CPP_INCLUDE_DIR(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:

        begin
            Result := GetTDMGCCDir;
            if (Result = '') then
                Result := COMMON_CPP_INCLUDE_DIR + GCC_CPP_INCLUDE_DIR
            else
                Result := Result + pd + 'include';

        end;

        ID_COMPILER_VC2010:

            Result := GetVC2010Include + VC2010_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;


        ID_COMPILER_VC2008:
            Result := GetVC2008Include + VC2008_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC2005:
            Result := GetVC2005Include + VC2005_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC2003:
            Result := GetVC2003Include + VC2003_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC6:
            Result := GetVC6Include + VC6_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_DMARS:
            Result := COMMON_CPP_INCLUDE_DIR + DMARS_CPP_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := COMMON_CPP_INCLUDE_DIR + BORLAND_CPP_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := COMMON_CPP_INCLUDE_DIR + WATCOM_CPP_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_CPP_INCLUDE_DIR;
    end;
end;

function RC_INCLUDE_DIR(CompilerID: integer): string;
begin
    case CompilerID of
        ID_COMPILER_MINGW:
            Result := GCC_RC_INCLUDE_DIR;

        ID_COMPILER_VC2010:
            Result := GetVC2010Include + VC2010_RC_INCLUDE_DIR;

        ID_COMPILER_VC2008:
            Result := GetVC2008Include + VC2008_RC_INCLUDE_DIR;

        ID_COMPILER_VC2005:
            Result := GetVC2005Include + VC2005_RC_INCLUDE_DIR;

        ID_COMPILER_VC2003:
            Result := GetVC2003Include + VC2003_RC_INCLUDE_DIR;

        ID_COMPILER_VC6:
            Result := GetVC6Include + VC6_RC_INCLUDE_DIR;

        ID_COMPILER_DMARS:
            Result := DMARS_RC_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_RC_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_RC_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_RC_INCLUDE_DIR;
    end;
end;


function GetVC6Path(PathType: integer): string;
var
    strInclude, strBin, strLib, TempString: string;
    reverseList: TStringList;
    i: integer;
begin
    TempString := 'Software\Microsoft\DevStudio\6.0\Build System\Components\Platforms\Win32 (x86)\Directories\';

    case PathType of
        0:
        begin
            TempString := TempString + 'Include Dirs';
            strInclude := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strInclude + ';';
        end;
        1:
        begin
            TempString := TempString + 'Path Dirs';
            strBin := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strBin + ';';
        end;
        2:
        begin

            TempString := TempString + 'Library Dirs';
            strLib := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strLib + ';';
        end;
    end;
    reverseList := TStringList.Create;
    StrToArrays(Result, ';', reverseList);
    Result := '';
    for i := reverseList.Count - 1 downto 0 do
    begin
        Result := Result + ';' + reverseList[i];
    end;

    //reverseList.destroy;
    Result := Result + ';';

end;

function GetRefinedPathList(StrPathValue, strVSInstallPath,
    strVCPPInstallPath, strFSDKInstallDir, strWinSDKPath: string): string;
var
    strLst: TStringList;
    i: integer;
begin
    strLst := TStringList.Create;
    strVCPPInstallPath := IncludeTrailingPathDelimiter(strVCPPInstallPath);
    strVSInstallPath := IncludeTrailingPathDelimiter(strVSInstallPath);
    strWinSDKPath := IncludeTrailingPathDelimiter(strWinSDKPath);

    StrPathValue := StringReplace(StrPathValue, '$(VCInstallDir)',
        strVCPPInstallPath, [rfReplaceAll, rfIgnoreCase]);
    StrPathValue := StringReplace(StrPathValue, '$(VSInstallDir)',
        strVSInstallPath, [rfReplaceAll, rfIgnoreCase]);
    StrPathValue := StringReplace(StrPathValue, '$(WinSDKDir)',
        strWinSDKPath, [rfReplaceAll, rfIgnoreCase]);
    Result := StrPathValue;
    StrToArrays(Result, ';', strLst);
    Result := '';
    for i := strLst.Count - 1 downto 0 do
        Result := Result + ';' + strLst[i];
    Result := Result + ';';
    strLst.Free;
end;

function GetWinSDKDir: string;
var
    strFSDKInstallDir: string;
    TempString: string;
    reg, reg2: TRegistry;
    strLst: TStringList;
    i: integer;
begin
    reg := TRegistry.Create;
    reg2 := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg2.RootKey := HKEY_LOCAL_MACHINE;

    TempString := 'SOFTWARE\Microsoft\MicrosoftSDK\InstalledSDKs';
    strLst := TStringList.Create;
    if (reg.OpenKey(TempString, FALSE)) then
    begin
        reg.GetKeyNames(strLst);
        for i := 0 to strLst.Count - 1 do
        begin
            TempString := 'SOFTWARE\Microsoft\MicrosoftSDK\InstalledSDKs\' + strLst[i];
            if (reg2.OpenKey(TempString, FALSE)) then
            begin
                strFSDKInstallDir := reg2.ReadString('Install Dir');
                if (strFSDKInstallDir <> '') then
                    break;
            end;
        end;
    end;

    if trim(strFSDKInstallDir) = '' then
        Result := 'Invalid_SDK_DIR'
    else
        Result := strFSDKInstallDir;

    strLst.Free;
    reg.CloseKey;
    reg2.CloseKey;

    reg.Free;
    reg2.Free;
end;

function GetVC200XPath(versionString: string; PathType: integer): string;
var
    strVSInstallDir,
    strVCPPInstallDir,
    strInclude,
    strBin,
    strLib,
    strFSDKInstallDir, strWinSDKDir: string;
    TempString: string;
    reg: TRegistry;
    reg2: TRegistry;
begin
    reg := TRegistry.Create;
    reg2 := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg2.RootKey := HKEY_LOCAL_MACHINE;
    try
        TempString := Format('SOFTWARE\Microsoft\VisualStudio\%s\Setup\VC\',
            [VersionString]);
        if (reg.OpenKey(TempString, FALSE) = FALSE) then
            strVCPPInstallDir := ''
        else
        begin
            strVCPPInstallDir := reg.ReadString('ProductDir');
            reg.CloseKey;
        end;

        if strVCPPInstallDir = '' then
        begin
            TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\VC7\';
            if reg2.OpenKey(TempString, FALSE) = FALSE then
            begin
                reg.Free;
                reg2.Free;
                exit;
            end;
            strVCPPInstallDir := reg2.ReadString(versionString);
            reg2.CloseKey;
        end;

        TempString := Format('SOFTWARE\Microsoft\VisualStudio\%s\Setup\VS\',
            [VersionString]);
        if (reg.OpenKey(TempString, FALSE) = FALSE) then
            strVSInstallDir := ''
        else
        begin
            strVSInstallDir := reg.ReadString('ProductDir');
            reg.CloseKey;
        end;

        if strVSInstallDir = '' then
        begin
            TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\VS7\';
            if reg2.OpenKey(TempString, FALSE) = FALSE then
            begin
                reg.Free;
                reg2.Free;
                exit;
            end;
            strVSInstallDir := reg2.ReadString(versionString);
            reg2.CloseKey;
        end;

        if (strVCPPInstallDir = '') then
        begin
            if versionString = '7.1' then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio .NET 2003\Vc7\';
            if versionString = '8.0' then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio\Vc8\';
            if versionString = '9.0' then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio 9.0\VC\';
            if versionString = '10.0' then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio 10.0\VC\';
        end;

        TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\FRAMEWORKSDK\';
        if (reg.OpenKey(TempString, FALSE)) then
        begin
            strFSDKInstallDir := reg.ReadString(VersionString);
            if trim(strFSDKInstallDir) = '' then
            begin
                strFSDKInstallDir := reg.ReadString('10.0');
                if trim(strFSDKInstallDir) = '' then
                    strFSDKInstallDir := reg.ReadString('9.0');
                if trim(strFSDKInstallDir) = '' then
                    strFSDKInstallDir := reg.ReadString('8.0');
                if trim(strFSDKInstallDir) = '' then
                    strFSDKInstallDir := reg.ReadString('7.1');
            end;
        end;
        reg.CloseKey;

        // On Windows 7, they moved to their own registry item
        if trim(strFSDKInstallDir) = '' then
        begin

            TempString := 'SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.0A';
            if (reg.OpenKey(TempString, FALSE)) then
            begin
                strFSDKInstallDir := reg.ReadString('InstallationFolder');
            end;
            reg.CloseKey;

        end;

        //Guru : Make sure we set some invalid names to the dir,
        //otherwise with the empty string it will set \include and
        //this will be mapped to mingW's Include path
        if (strVSInstallDir = '') then
            strVSInstallDir := 'VSInstall_INVALID_FOLDER';

        strWinSDKDir := GetWinSDKDir;
        if (strWinSDKDir = '') then
        begin
            if versionString = '10.0' then
                strWinSDKDir := GetProgramFilesDir + '\Microsoft SDKs\'
            else
            if versionString = '9.0' then
                strWinSDKDir := GetProgramFilesDir + '\Microsoft SDKs\'
            else
                strWinSDKDir := 'WinSDK_INVALID_FOLDER';
        end;

        TempString := Format(
            'SOFTWARE\Microsoft\VisualStudio\%s\VC\VC_OBJECTS_PLATFORM_INFO\Win32\Directories\',
            [VersionString]);
        if (reg.OpenKey(TempString, FALSE)) then
        begin
            strInclude := reg.ReadString('Include Dirs');
            strBin := reg.ReadString('Path Dirs');
            strLib := reg.ReadString('Library Dirs');
            reg.CloseKey;
        end
        else
        begin
            strInclude := '';
            strBin := '';
            strLib := '';
        end;
        case PathType of
            0:
            begin

                if Trim(strInclude) = '' then
                    strInclude :=
                        '$(VCInstallDir)include;$(VCInstallDir)atlmfc\include;$(VCInstallDir)PlatformSDK\include\prerelease;$(VCInstallDir)PlatformSDK\include;$(FrameworkSDKDir)include;';
                if (versionString = '9.0') then
                    strInclude :=
                        strInclude + ';' + StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Include;'
                else
                if (StrToFloatInternational(versionString) >= 10.0) then
                    strInclude := strInclude + ';' + IncludeTrailingPathDelimiter(strFSDKInstallDir) + 'include';

                strInclude := strInclude + ';$(WinSDKDir)include;';
                Result := GetRefinedPathList(
                    strInclude, strVSInstallDir, strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            end;
            1:
            begin

                if Trim(strBin) = '' then
                    strBin :=
                        '$(VCInstallDir)bin;$(VSInstallDir)Common7\Tools\bin\prerelease;$(VSInstallDir)Common7\Tools\bin;$(VSInstallDir)Common7\tools;$(VSInstallDir)Common7\ide;' + GetProgramFilesDir + '\HTML Help Workshop\;$(FrameworkSDKDir)bin;$(FrameworkDir)$(FrameworkVersion);';
                if (versionString = '9.0') then
                    strBin := strBin + ';' +
                        StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Bin;'
                else
                if (StrToFloatInternational(versionString) >= 10.0) then
                    strBin := strBin + ';' + IncludeTrailingPathDelimiter(strFSDKInstallDir) + 'bin';

                strBin := strBin + ';$(WinSDKDir)bin;';
                Result := GetRefinedPathList(strBin, strVSInstallDir,
                    strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            end;
            2:
            begin
                if Trim(strLib) = '' then
                    strLib :=
                        '$(VCInstallDir)lib;$(VCInstallDir)atlmfc\lib;$(VCInstallDir)PlatformSDK\lib\prerelease;$(VCInstallDir)PlatformSDK\lib;$(FrameworkSDKDir)lib';
                if (versionString = '9.0') then
                    strLib := strLib + ';' +
                        StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Lib;'
                else
                if (StrToFloatInternational(versionString) >= 10.0) then
                    strLib := strLib + ';' + IncludeTrailingPathDelimiter(strFSDKInstallDir) + 'lib';

                strLib := strLib + ';$(WinSDKDir)lib;';
                Result := GetRefinedPathList(strLib, strVSInstallDir,
                    strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            end;
        end;
    finally
    end;

    reg.Free;
    reg2.Free;

end;

function GetVC2010Include: string;
begin
    Result := GetVC200XPath('10.0', 0);
end;

function GetVC2008Include: string;
begin
    Result := GetVC200XPath('9.0', 0);
end;

function GetVC2005Include: string;
begin
    Result := GetVC200XPath('8.0', 0);
end;

function GetVC2003Include: string;
begin
    Result := GetVC200XPath('7.1', 0);
end;

function GetVC6Include: string;
begin
    Result := GetVC6Path(0);
end;

function GetVC2010Bin: string;
begin
    Result := GetVC200XPath('10.0', 1);
end;

function GetVC2008Bin: string;
begin
    Result := GetVC200XPath('9.0', 1);
end;

function GetVC2005Bin: string;
begin
    Result := GetVC200XPath('8.0', 1);
end;

function GetVC2003Bin: string;
begin
    Result := GetVC200XPath('7.1', 1);
end;

function GetVC6Bin: string;
begin
    Result := GetVC6Path(1);
end;

function GetVC2010Lib: string;
begin
    Result := GetVC200XPath('10.0', 2);
end;

function GetVC2008Lib: string;
begin
    Result := GetVC200XPath('9.0', 2);
end;

function GetVC2005Lib: string;
begin
    Result := GetVC200XPath('8.0', 2);
end;

function GetVC2003Lib: string;
begin
    Result := GetVC200XPath('7.1', 2);
end;

function GetVC6Lib: string;
begin
    Result := GetVC6Path(2);
end;

function GetTDMGCCDir: string;
var
    Reg: TRegistry;
begin

    Reg := TRegistry.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall\TDM-GCC', FALSE) then
        begin
            Result := Reg.ReadString('InstallLocation');
        end
        else
            Result := '';

        Reg.CloseKey;
    finally
        Reg.Free;
    end;

end;

end.
