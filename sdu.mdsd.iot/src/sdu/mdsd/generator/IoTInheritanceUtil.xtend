package sdu.mdsd.generator

import java.util.HashMap
import sdu.mdsd.ioT.ControllerDevice
import sdu.mdsd.ioT.Device
import sdu.mdsd.ioT.IoTDevice
import sdu.mdsd.ioT.Loop
import sdu.mdsd.ioT.VarOrList
import sdu.mdsd.ioT.ConnectStatement

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
	
	def inheritConnectionsFromParents(Device d){
		var conMap = new HashMap<String, ConnectStatement>()
		val parent = d.getParentDevice
		
		for(c : parent.program.connectStatements){
			conMap.put(c.name, c)
		}		
		return conMap
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
	
	def makeConnectionsMap(Device d) {
		var conMap = d.getParentDevice === null ? new HashMap<String, ConnectStatement>() : d.inheritConnectionsFromParents;
		generateConnectionsMap(d, conMap)
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
	
	private def HashMap<String, ConnectStatement> generateConnectionsMap(Device d, HashMap<String, ConnectStatement> conMap) {
		for(c : d.program.connectStatements){
			if (!conMap.containsKey(c.name)){
				conMap.put(c.name, c)
				}
			else {
				conMap.replace(c.name, c)
			}
		}
		return conMap
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