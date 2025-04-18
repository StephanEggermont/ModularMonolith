Class {
	#name : #MMProcess,
	#superclass : #Object,
	#instVars : [
		'processName',
		'context'
	],
	#category : #'ModularMonolith-Kernel'
}

{ #category : #accessing }
MMProcess class >> named: aString in: aBoundedContext [
	^self new
		processName: aString;
		context: aBoundedContext;
		yourself
]

{ #category : #accessing }
MMProcess >> context [
	^ context
]

{ #category : #accessing }
MMProcess >> context: anObject [
	context := anObject
]

{ #category : #'as yet unclassified' }
MMProcess >> processDefinition [
	^self context processDefinitionFor: self
]

{ #category : #accessing }
MMProcess >> processName [
	^ processName
]

{ #category : #accessing }
MMProcess >> processName: anObject [
	processName := anObject
]
