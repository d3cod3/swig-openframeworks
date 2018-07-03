// workaround when compiling in MinGW (Python)
%begin %{
#if defined( __WIN32__ ) || defined( _WIN32 )
	#include <cmath>
#endif
%}

// ofxAddons MODULE
%module MODULE_NAME
%{
	#include "ofxAssimpModelLoader.h"
	#include "ofxGui.h"
	#include "ofxNetwork.h"
	#include "ofxOpenCv.h"
	#include "ofxOsc.h"
	#include "ofxOscParameterSync.h"
	#include "ofxSvg.h"
	#include "ofxVectorGraphics.h"
	#include "ofxXmlSettings.h"
%}
%include <attribute.i>
%include <typemaps.i>

// custom attribute wrapper for nested union var access
%define %attributeVar(Class, AttributeType, AttributeName, GetVar, SetVar...)
	#if #SetVar != ""
		%attribute_custom(%arg(Class), %arg(AttributeType), AttributeName, GetVar, SetVar, self_->GetVar, self_->SetVar = val_)
	#else
		%attribute_readonly(%arg(Class), %arg(AttributeType), AttributeName, GetVar, self_->GetVar)
	#endif
%enddef

// ----- C++ -----

// SWIG doesn't understand C++ streams
%ignore operator <<;
%ignore operator >>;

// expanded primitives
%typedef unsigned int size_t;
%typedef long long int64_t;
%typedef unsigned long long uint64_t;
%typedef int int32_t;
%typedef unsigned int uint32_t;

%typedef std::string string;

%include <stl.i>
%include <std_string.i>
%include <std_vector.i>
%include <std_map.i>

// SWIG needs to know about the deprecation macro
#define OF_DEPRECATED_MSG(m, f)

// ----- Renaming -----

#ifdef OF_SWIG_RENAME

	// strip "ofx" prefix from classes
	%rename("%(strip:[ofx])s", %$isclass) "";

	// strip "ofx" prefix from global functions & make first char lowercase
	%rename("%(regex:/ofx(.*)/\\l\\1/)s", %$isfunction) "";

	// strip "OFXOSC_" from constants & enums
	%rename("%(strip:[OFX])s", %$isconstant) "";
	%rename("%(strip:[OFX])s", %$isenumitem) "";

#endif

// ----- Lang specifics ------

#ifdef SWIGLUA
%include "interfaces/lang/lua/lua.i"
#endif

#ifdef SWIGPYTHON
	// ----- operator overloads -----

	%rename(__getitem__) *::operator[];
	%rename(__mul__) *::operator*;
	%rename(__div__) *::operator/;
	%rename(__add__) *::operator+;
	%rename(__sub__) *::operator-;
#endif

// CORE OFXADDONS

// ----- ofxAssimpModelLoader -----

%include "../../ofxAssimpModelLoader/src/ofxAssimpMeshHelper.h"
%include "../../ofxAssimpModelLoader/src/ofxAssimpAnimation.h"
%include "../../ofxAssimpModelLoader/src/ofxAssimpTexture.h"

// ----- ofxGui -----

%ignore ofxBaseGui;
class ofxBaseGui {};

%ignore ofxToggle::operator const bool & ();

%include "../../ofxGui/src/ofxToggle.h"
%include "../../ofxGui/src/ofxButton.h"
%include "../../ofxGui/src/ofxColorPicker.h"
%include "../../ofxGui/src/ofxInputField.h"

%ignore ofxLabel::operator const std::string & ();

%include "../../ofxGui/src/ofxLabel.h"

%ignore ofxGuiGroup;
class ofxGuiGroup {};

%include "../../ofxGui/src/ofxPanel.h"
%include "../../ofxGui/src/ofxSlider.h"


// ----- ofxNetwork -----
%ignore InetAddr;

%ignore ofThread;
class ofThread {};

%ignore ofxTCPClient::threadedFunction();

%include "../../ofxNetwork/src/ofxTCPClient.h"
%include "../../ofxNetwork/src/ofxTCPManager.h"
%include "../../ofxNetwork/src/ofxTCPServer.h"
%include "../../ofxNetwork/src/ofxUDPManager.h"

// ----- ofxOpenCv -----

%ignore ofBaseDraws;
class ofBaseDraws {};

%ignore ofBaseImage;
class ofBaseImage {};

%ignore ofxCvImage::operator &= ( ofxCvImage& mom );

%include "../../ofxOpenCv/src/ofxCvImage.h"

%include "../../ofxOpenCv/src/ofxCvBlob.h"
%include "../../ofxOpenCv/src/ofxCvGrayscaleImage.h"
%include "../../ofxOpenCv/src/ofxCvColorImage.h"

%ignore ofxCvFloatImage::operator &= ( ofxCvImage& mom );

%include "../../ofxOpenCv/src/ofxCvFloatImage.h"
%include "../../ofxOpenCv/src/ofxCvShortImage.h"
%include "../../ofxOpenCv/src/ofxCvContourFinder.h"
%include "../../ofxOpenCv/src/ofxCvHaarFinder.h"

// ----- ofxOsc -----

// dummy forward declare for ofxOscReceiver which inherits from OscPacketListener
%ignore osc::OscPacketListener;
namespace osc {
	class OscPacketListener {};
}

// don't bind argument types since they are only used internally by ofxOscMessage
%ignore ofxOscArg;
%ignore ofxOscArgInt32;
%ignore ofxOscArgInt;
%ignore ofxOscArgInt64;
%ignore ofxOscArgFloat;
%ignore ofxOscArgDouble;
%ignore ofxOscArgString;
%ignore ofxOscArgSymbol;
%ignore ofxOscArgChar;
%ignore ofxOscArgMidiMessage;
%ignore ofxOscArgBool;
%ignore ofxOscArgNone;
%ignore ofxOscArgTrigger;
%ignore ofxOscArgTimetag;
%ignore ofxOscArgBlob;
%ignore ofxOscArgRgbaColor;

// deprecations
%ignore ofxOscReceiver::getNextMessage(ofxOscMessage *);

// convert returned enum values to lua strings since
// ofxOscArgType enums are stored as strings
#ifdef SWIGLUA
%typemap(out) ofxOscArgType {
	switch((char)$1) {
		case 'i': lua_pushstring(L, "i"); break;
		case 'h': lua_pushstring(L, "h"); break;
		case 'f': lua_pushstring(L, "f"); break;
		case 'd': lua_pushstring(L, "d"); break;
		case 's': lua_pushstring(L, "s"); break;
		case 'S': lua_pushstring(L, "S"); break;
		case 'c': lua_pushstring(L, "c"); break;
		case 'm': lua_pushstring(L, "m"); break;
		case 'T': lua_pushstring(L, "T"); break;
		case 'F': lua_pushstring(L, "F"); break;
		case 'N': lua_pushstring(L, "N"); break;
		case 'I': lua_pushstring(L, "I"); break;
		case 't': lua_pushstring(L, "t"); break;
		case 'b': lua_pushstring(L, "b"); break;
		case 'B': lua_pushstring(L, "B"); break;
		case 'r': lua_pushstring(L, "r"); break;
		default:  lua_pushstring(L, "\0"); break;
	}
	SWIG_arg++;
}
#endif

// includes
%include "../../ofxOsc/src/ofxOscArg.h"
%include "../../ofxOsc/src/ofxOscBundle.h"
%include "../../ofxOsc/src/ofxOscMessage.h"
%include "../../ofxOsc/src/ofxOscParameterSync.h"
%include "../../ofxOsc/src/ofxOscReceiver.h"
%include "../../ofxOsc/src/ofxOscSender.h"

#ifdef ATTRIBUTES

// convenience attributes
%attributestring(ofxOscMessage, string, address, getAddress, setAddress)
%attributestring(ofxOscMessage, string, remoteHost, getRemoteIp)
%attribute(ofxOscMessage, int, remotePort, getRemotePort)
%attribute(ofxOscMessage, int, numArgs, getNumArgs);
%attribute(ofxOscBundle, int, messageCount, getMessageCount);
%attribute(ofxOscBundle, int, bundleCount, getBundleCount);

#endif

%extend ofxOscMessage {

	// message tostring method
	const char* __str__() {
		static char str[255]; // provide a valid return pointer
		std::stringstream stream;
		stream << $self->getAddress();
		for(int i = 0; i < $self->getNumArgs(); ++i) {
			stream << " ";
			switch($self->getArgType(i)) {
				case OFXOSC_TYPE_INT32:
					stream << $self->getArgAsInt32(i);
					break;
				case OFXOSC_TYPE_INT64:
					stream << $self->getArgAsInt64(i);
					break;
				case OFXOSC_TYPE_FLOAT:
					stream << $self->getArgAsFloat(i);
					break;
				case OFXOSC_TYPE_DOUBLE:
					stream << $self->getArgAsDouble(i);
					break;
				case OFXOSC_TYPE_STRING:
					stream << $self->getArgAsString(i);
					break;
				case OFXOSC_TYPE_SYMBOL:
					stream << $self->getArgAsSymbol(i);
					break;
				case OFXOSC_TYPE_CHAR:
					stream << $self->getArgAsChar(i);
					break;
				case OFXOSC_TYPE_MIDI_MESSAGE:
					stream << ofToHex($self->getArgAsMidiMessage(i));
					break;
				case OFXOSC_TYPE_TRUE:
					stream << "T";
					break;
				case OFXOSC_TYPE_FALSE:
					stream << "F";
					break;
				case OFXOSC_TYPE_NONE:
					stream << "NONE";
					break;
				case OFXOSC_TYPE_TRIGGER:
					stream << "TRIGGER";
					break;
				case OFXOSC_TYPE_TIMETAG:
					stream << "TIMETAG";
					break;
				case OFXOSC_TYPE_BLOB:
					stream << "BLOB";
					break;
				case OFXOSC_TYPE_RGBA_COLOR:
					stream << ofToHex($self->getArgAsRgbaColor(i));
					break;
				default:
					break;
			}
		}
		sprintf(str, "%.255s", stream.str().c_str()); // copy & restrict length
		return str;
	}
};

// ----- ofxSvg -----

%include "../../ofxSvg/src/ofxSvg.h"

// ----- ofxVectorGraphics -----

// SWIG needs to know about ns_creeps or it throws an error
namespace ns_creeps {}

%include "../../ofxVectorGraphics/src/ofxVectorGraphics.h"

// ----- ofxXmlSettings -----

%ignore ofxXmlSettings::getValue(const string&  tag, int defaultValue, int which = 0) const;
%ignore ofxXmlSettings::getValue(const string&  tag, double defaultValue, int which = 0) const;

%ignore ofxXmlSettings::setValue(const string&  tag, int value, int which = 0);
%ignore ofxXmlSettings::setValue(const string&  tag, double value, int which = 0);

%ignore ofxXmlSettings::addValue(const string&  tag, int value);
%ignore ofxXmlSettings::addValue(const string&  tag, double value);

%ignore ofxXmlSettings::addAttribute(const string& tag, const string& attribute, int value, int which = 0);
%ignore ofxXmlSettings::addAttribute(const string& tag, const string& attribute, double value, int which = 0);
%ignore ofxXmlSettings::addAttribute(const string& tag, const string& attribute, int value);
%ignore ofxXmlSettings::addAttribute(const string& tag, const string& attribute, double value);
%ignore ofxXmlSettings::addAttribute(const string& tag, const string& attribute, const string& value);

%ignore ofxXmlSettings::getAttribute(const string& tag, const string& attribute, int defaultValue, int which = 0) const;
%ignore ofxXmlSettings::getAttribute(const string& tag, const string& attribute, double defaultValue, int which = 0) const;

%ignore ofxXmlSettings::setAttribute(const string& tag, const string& attribute, int value, int which = 0);
%ignore ofxXmlSettings::setAttribute(const string& tag, const string& attribute, double value, int which = 0);
%ignore ofxXmlSettings::setAttribute(const string& tag, const string& attribute, int value);
%ignore ofxXmlSettings::setAttribute(const string& tag, const string& attribute, double value);
%ignore ofxXmlSettings::setAttribute(const string& tag, const string& attribute, const string& value);

%include "../../ofxXmlSettings/src/ofxXmlSettings.h"
