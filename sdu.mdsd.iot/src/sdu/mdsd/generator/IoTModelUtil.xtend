package sdu.mdsd.generator

import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.IoTDevice
import sdu.mdsd.ioT.ControllerDevice
import sdu.mdsd.ioT.NamedDeclaration
import org.eclipse.emf.ecore.EObject

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
    	d.classHierarchy.map[program.eAllContents.filter(NamedDeclaration).toList].flatten
    }
	
	def Device getContainingDevice(EObject o){
		if (o.eContainer instanceof Device){
			return o.eContainer as Device
		} else {
			return o.eContainer.getContainingDevice
		}
	}
    
    
    
}