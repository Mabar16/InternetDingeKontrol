package sdu.mdsd.generator

import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.NamedDeclaration
import org.eclipse.emf.ecore.EObject
import javax.inject.Inject
import sdu.mdsd.ioT.Model

class IoTModelUtil {
	
	@Inject extension IoTInheritanceUtil
	
	def classHierarchy(Device d) {
		val visited = newLinkedHashSet()
		var current = d.getParentDevice
		while (current !== null && !visited.contains(current)) {
			visited.add(current)
			current = current.getParentDevice
		}
		visited

	}

    def classHierarchyMembers(Device d){
    	d.classHierarchy.map[program.eAllContents.filter(NamedDeclaration).toList].flatten
    }
	
	def Device getContainingDevice(EObject o){
		if (o.eContainer instanceof Device){
			return o.eContainer as Device
		} else {
			return o.eContainer.getContainingDevice
		}
	}
	
	def Model getModel(EObject o){
		if (o.eContainer instanceof Model){
			return o.eContainer as Model
		} else {
			return o.eContainer.getModel
		}
	}
    
    
    
}