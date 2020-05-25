package sdu.mdsd.generator

import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.IoTDevice
import sdu.mdsd.ioT.ControllerDevice

class IDKModelUtil {
	
	def loops(Device d) {
		d.program.loops
	}
	
	def classHierarchy(IoTDevice d) {
		val visited = newLinkedHashSet()
		var current = d.parent
		while (current !== null && !visited.contains(current)) {
			visited.add(current)
			current = current.parent
		}
		visited
    }
    
    	def classHierarchy(ControllerDevice d) {
		val visited = newLinkedHashSet()
		var current = d.parent
		while (current !== null && !visited.contains(current)) {
			visited.add(current)
			current = current.parent
		}
		visited
    }
}