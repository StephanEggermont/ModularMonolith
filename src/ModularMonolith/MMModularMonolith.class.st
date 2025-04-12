Class {
	#name : #MMModularMonolith,
	#superclass : #Object,
	#instVars : [
		'boundedContexts'
	],
	#category : #'ModularMonolith-Kernel'
}

{ #category : #'as yet unclassified' }
MMModularMonolith >> findOrNewBoundedContext: aString [ 
	^ boundedContexts at: aString ifAbsentPut: [MMBoundedContext named: aString].
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> initialize [
	boundedContexts := Dictionary new
]
