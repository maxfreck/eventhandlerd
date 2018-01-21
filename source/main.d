module main;

import core.stdc.stdint: uintptr_t;
import core.sys.posix.syslog;
import deadbeef.deadbeef;

extern (C):
@trusted:
nothrow:
@nogc:

static DB_functions_t* deadBeef;

static int eventhandler_message(uint id, uintptr_t ctx, uint p1, uint p2) {
	openlog("ddb eventhandlerd", LOG_PID|LOG_CONS, LOG_USER);

	switch (id) {
	case DB_EV_SEEKED:
		syslog (LOG_INFO, "DB_EV_SEEKED\n");
		break;
	case DB_EV_TRACKINFOCHANGED:
		syslog (LOG_INFO, "DB_EV_TRACKINFOCHANGED\n");
		break;
	case DB_EV_SONGSTARTED:
		syslog (LOG_INFO, "DB_EV_SONGSTARTED\n");
		break;
	case DB_EV_PAUSED:
		syslog (LOG_INFO, "DB_EV_PAUSED\n");
		break;
	case DB_EV_STOP:
		syslog (LOG_INFO, "DB_EV_STOP\n");
		break;
	case DB_EV_VOLUMECHANGED:
		syslog (LOG_INFO, "DB_EV_VOLUMECHANGED\n");
		break;
	case DB_EV_CONFIGCHANGED:
		syslog (LOG_INFO, "DB_EV_CONFIGCHANGED\n");
		break;
	default:
		syslog (LOG_INFO, "Unknown event #%u\n", id);
		break;
	}

	closelog();
	return 0;
}

DB_misc_t plugin = {
	plugin: {
		api_vmajor: DB_API_VERSION_MAJOR,
		api_vminor: DB_API_VERSION_MINOR,
		type: DB_PLUGIN_MISC,
		version_major: 1,
		version_minor: 0,
		id: "example",
		name: "Event Handler Example",
		descr: "Example event handler plugin",
		copyright: "copyright message - author(s), license, etc",
		message: &eventhandler_message,
	}
};

DB_plugin_t* eventhandlerd_load(DB_functions_t *ddb) {
	deadBeef = ddb;
	return cast(DB_plugin_t*)(&plugin);
}