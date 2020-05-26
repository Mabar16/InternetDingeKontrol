package sdu.mdsd.generator

import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.IoTDevice
import sdu.mdsd.ioT.ControllerDevice

class IoTModelUtil {
	def classHierarchy(Device d) {
		switch(d){
			IoTDevice: {
				val visited = newLinkedHashSet()
				var current = d.parent
				while (current !== null && !visited.contains(current)) {
					visited.add(current)
					current = current.parent
				}
				visited	}
			ControllerDevice: {
				val visited = newLinkedHashSet()
				var current = d.parent
				while (current !== null && !visited.contains(current)) {
					visited.add(current)
					current = current.parent
				}
				visited}
			}
		}
        
    def classHierarchyVariables(Device d){
    	d.classHierarchy.map[program.variables].flatten
    }
    
    
}