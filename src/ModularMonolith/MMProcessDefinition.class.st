Class {
	#name : #MMProcessDefinition,
	#superclass : #Object,
	#instVars : [
		'processName',
		'context'
	],
	#category : #'ModularMonolith-Kernel'
}

{ #category : #'as yet unclassified' }
MMProcessDefinition class >> named: aProcessName in: aBoundedContext [
	^self new
		processName: aProcessName;
		context: aBoundedContext;
		yourself
]

{ #category : #'as yet unclassified' }
MMProcessDefinition >> context: aBoundedContext [ 
	context := aBoundedContext
]

{ #category : #'as yet unclassified' }
MMProcessDefinition >> processName: aProcessName [
	processName := aProcessName
]
