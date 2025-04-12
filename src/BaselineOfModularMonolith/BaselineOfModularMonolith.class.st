Class {
	#name : #BaselineOfModularMonolith,
	#superclass : #BaselineOf,
	#category : #BaselineOfModularMonolith
}

{ #category : #loading }
BaselineOfModularMonolith class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'ModularMonolith' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfModularMonolith >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'ModularMonolith'
		]
]
