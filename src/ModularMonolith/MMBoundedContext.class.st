Class {
	#name : #MMBoundedContext,
	#superclass : #Object,
	#instVars : [
		'contextName',
		'processes'
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
	processes := Dictionary new
]

{ #category : #accessing }
MMBoundedContext >> process: aString [ 
	^ processes at: aString ifAbsentPut: [MMProcess named: aString in: self.].
]
