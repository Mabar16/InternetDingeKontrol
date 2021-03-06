/*
 * generated by Xtext 2.20.0
 */
package sdu.mdsd.ide

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import sdu.mdsd.IoTRuntimeModule
import sdu.mdsd.IoTStandaloneSetup

/**
 * Initialization support for running Xtext languages as language servers.
 */
class IoTIdeSetup extends IoTStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new IoTRuntimeModule, new IoTIdeModule))
	}
	
}
