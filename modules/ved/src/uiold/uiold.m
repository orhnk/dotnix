void focus_app(void* next, void* event, void* data) {
	NSLog(@"2The hot key was pressed.");
	NSApplication *myApp = [NSApplication sharedApplication];
	[myApp activateIgnoringOtherApps:YES];
	//return noErr;
}

void reg_key_ved2() {
	puts("REGISTERING VED KEY2");
	EventHotKeyRef gMyHotKeyRef;
	EventHotKeyID gMyHotKeyID;
	EventTypeSpec eventType;
	eventType.eventClass = kEventClassKeyboard;
	eventType.eventKind = kEventHotKeyPressed;
	InstallApplicationEventHandler(&focus_app, 1, &eventType, NULL, NULL);
	gMyHotKeyID.signature = 'rml1';
	gMyHotKeyID.id = 1;
	RegisterEventHotKey(kVK_ANSI_1, cmdKey, gMyHotKeyID,
		GetApplicationEventTarget(), 0, &gMyHotKeyRef);
}
