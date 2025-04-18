Class {
	#name : #MMBoundedContext,
	#superclass : #Object,
	#instVars : [
		'contextName',
		'processes',
		'processDefinitions'
	],
	#category : #'ModularMonolith-Kernel'
}

{ #category : #'as yet unclassified' }
MMBoundedContext class >> named: aString [ 
	^ self new
		contextName: aString;
		yourself
]

{ #category : #'as yet unclassified' }
MMBoundedContext >> contextName: aString [ 
	contextName := aString
]

{ #category : #'as yet unclassified' }
MMBoundedContext >> initialize [
	processes := Dictionary new.
	processDefinitions := Dictionary new.
]

{ #category : #accessing }
MMBoundedContext >> process: aString [ 
	^ processes at: aString ifAbsentPut: [MMProcess named: aString in: self.].
]

{ #category : #'as yet unclassified' }
MMBoundedContext >> processDefinitionFor: aProcess [
	^processDefinitions at: aProcess processName ifAbsentPut: [MMProcessDefinition named: aProcess processName in: self.].
]
