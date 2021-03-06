// events folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofEvent.h -----

// not needed

// ----- ofEvents.h -----

// DIFF: ofEvents.h:
// DIFF:   ignore event classes, event args, and registration functions
%ignore ofEventArgs;
%ignore ofEntryEventArgs;
%ignore ofKeyEventArgs;
%ignore ofMouseEventArgs;
// need ofTouchEventArgs for touch callbacks
%ignore ofAudioEventArgs;
%ignore ofResizeEventArgs;
%ignore ofWindowPosEventArgs;
%ignore ofMessage;
%ignore ofTimeMode;

%ignore ofCoreEvents;

// DIFF:   ignore ofSendMessage() with ofMessage in favor of std::string
%ignore ofSendMessage(ofMessage msg);

%ignore ofEvents;

%ignore ofRegisterMouseEvents;
%ignore ofRegisterKeyEvents;
%ignore ofRegisterTouchEvents;
%ignore ofRegisterGetMessages;
%ignore ofRegisterDragEvents;
%ignore ofUnregisterMouseEvents;
%ignore ofUnregisterKeyEvents;
%ignore ofUnregisterTouchEvents;
%ignore ofUnregisterGetMessages;
%ignore ofUnregisterDragEvents;

// glm::vec2 forward declare for ofTouchEventArgs
namespace glm {
	struct vec2 {};
}

%include "events/ofEvents.h"

// ----- ofEventUtils.h -----

// not needed
