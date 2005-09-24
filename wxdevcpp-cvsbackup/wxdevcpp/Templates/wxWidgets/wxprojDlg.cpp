//---------------------------------------------------------------------------
//
// Name:        %FILE_NAME%.cpp
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
// Description: 
//
//---------------------------------------------------------------------------

#include "%FILE_NAME%.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// %CLASS_NAME%
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(%CLASS_NAME%, wxDialog)
	////Manual Code Start
	////Manual Code End
	EVT_CLOSE(%CLASS_NAME%::%CLASS_NAME%Close)
END_EVENT_TABLE()
////Event Table End

%CLASS_NAME%::%CLASS_NAME%(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
    CreateGUIControls();
}

%CLASS_NAME%::~%CLASS_NAME%() {} 

void %CLASS_NAME%::CreateGUIControls(void)
{
    //Do not add custom code here
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start
	////GUI Items Creation End
}

void %CLASS_NAME%::%CLASS_NAME%Close(wxCloseEvent& event)
{
    Destroy();
}
 