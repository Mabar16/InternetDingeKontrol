package sdu.mdsd.generator

import sdu.mdsd.ioT.ListenDeclaration
import java.util.ArrayList
import sdu.mdsd.ioT.*
import java.util.HashSet
import java.util.HashMap
import javax.inject.Inject
import java.util.List

class ThreadSafetyHelper {

	@Inject extension IoTModelUtil
	@Inject extension IoTInheritanceUtil

	private def getCommandsFromListenDeclaration(ListenDeclaration l) {
		if (l === null)
			return new ArrayList<String>()

		var names = new ArrayList<String>()

		val listenBody = l.body

		getCriticalFromExpressionRight(listenBody, names)

		return names
	}

	private def void getCriticalFromExpressionRight(ExpressionRight listenBody, ArrayList<String> names) {
		switch (listenBody) {
			AddToList: {
				names.add(listenBody.list.name)
			}
			ToVar: {
				names.add(listenBody.variable.name)
			}
			Block: {
				for (c : listenBody.commands) {
					(getCriticalFromCommand(c, names))
				}
			}
			ClearListAction: {
				names.add(listenBody.list.name)
			}
			default: {
			}
		}
	}

	private def void getCriticalFromCommand(Command c, ArrayList<String> names) {
		switch c {
			ArrowCommand: {
				getCriticalSectionsFromArrowCommand(c, names)
			}
			ClearListAction: {
				names.add(c.list.name)
			}
			IfStatement: {
				getCommandsFromIf(c, names)
			}
		}
	}

	private def void getCriticalSectionsFromArrowCommand(ArrowCommand a, ArrayList<String> names) {
		val right = a.right

		getCriticalFromExpressionRight(right, names)
	}

	private def void getCommandsFromIf(IfStatement _if, ArrayList<String> names) {
		for (c : _if.commands) {
			getCriticalFromCommand(c, names)
		}

		if (_if.elseBlock !== null) {
			for (c : _if.elseBlock.commands)
				getCriticalFromCommand(c, names)
		}
	}

	private def List<String> getCriticalSectionsFromLoops(Device d) {
		var names = new ArrayList<String>()

		for (l : d.program.loops) {
			getSectionsFromLoop(l, names)
		}

		return names
	}

	private def void getSectionsFromLoop(Loop l, ArrayList<String> names) {
		for (c : l.commands) {
			getCriticalFromCommand(c, names)
		}
	}

	def HashSet<String> findCritcalSections(Device d) {
		var names = new HashSet<String>()
		var occurrences = new HashMap<String, Integer>()

		// Find all local variable/list mutations
		val mutations = d.listenDeclaration.commandsFromListenDeclaration
		mutations.addAll(d.criticalSectionsFromLoops)
		System.out.println("MUT" + mutations)

		// Count how often each variable is mutated
		for (entry : mutations) {
			if (!occurrences.containsKey(entry)) {
				occurrences.put(entry, 1)
			} else {
				occurrences.put(entry, occurrences.get(entry) + 1)
			}
		}

		// Include mutations inherited from parent
		val p = d.getParentDevice
		if (p !== null) {

			val pMutations = p.listenDeclaration.commandsFromListenDeclaration
			pMutations.addAll(p.criticalSectionsFromLoops)
			System.out.println("PM:" + pMutations)
			// Count inherited variable mutations
			for (entry : pMutations) {
				if (!occurrences.containsKey(entry)) {
					occurrences.put(entry, 1)
				} else {
					occurrences.put(entry, occurrences.get(entry) + 1)
				}
			}

		}
		for (kvpair : occurrences.entrySet) {
			if (kvpair.value > 1) {
				names.add(kvpair.key)
			}
		}

		return names
	}
}
