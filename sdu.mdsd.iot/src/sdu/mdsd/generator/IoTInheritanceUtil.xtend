package sdu.mdsd.generator

import java.util.HashMap
import sdu.mdsd.ioT.ControllerDevice
import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.IoTDevice
import sdu.mdsd.ioT.Loop
import sdu.mdsd.ioT.VarOrList

class IoTInheritanceUtil {
	def inheritLoopsFromParents(Device d){
		var loopMap = new HashMap<String, Loop>()
		val parent = d.getParentDevice
		
		for(l : parent.program.loops){
			loopMap.put(l.name, l)
		}
		
		return loopMap
	}
	
	def inheritVariablesFromParents(Device d){
		var varMap = new HashMap<String, VarOrList>()
		val parent = d.getParentDevice
		
		for(v : parent.program.variables){
			varMap.put(v.name, v)
		}		
		return varMap
	}
	
	def dispatch getParentDevice(IoTDevice d){
		return d.parent
	}
	
	def dispatch getParentDevice(ControllerDevice d){
		return d.parent
	}
	
	def makeLoopMap(Device d) {
		var loopMap = d.getParentDevice === null ? new HashMap<String, Loop>() : d.inheritLoopsFromParents;
		generateLoopMap(d, loopMap)
	}

	
	private def HashMap<String, Loop> generateLoopMap(Device d, HashMap<String, Loop> loopMap) {
		for(l : d.program.loops){
			if (!loopMap.containsKey(l.name)){
				loopMap.put(l.name, l)
				}
			else {
				loopMap.replace(l.name, l)
			}
		}
		return loopMap
	}
	
	
	
	def makeVarMap(Device d){
		var varMap = d.getParentDevice === null ? new HashMap<String, VarOrList>() : d.inheritVariablesFromParents;
		generateVariableMap(d, varMap)
	}
	
	private def HashMap<String, VarOrList> generateVariableMap(Device d, HashMap<String, VarOrList> varMap) {
		for(v : d.program.variables){
			if (!varMap.containsKey(v.name)){
				varMap.put(v.name, v)
				}
			else {
				varMap.replace(v.name, v)
			}
		}
		return varMap
	}
}