Class {
	#name : #MMModularMonolith,
	#superclass : #Object,
	#instVars : [
		'boundedContexts'
	],
	#category : #'ModularMonolith-Kernel'
}

{ #category : #'as yet unclassified' }
MMModularMonolith >> classParserModel [
	<gtExample>
	^self packageViewIncluding: CDClassDefinitionParser
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> colorForClass: aClass [
	(aClass methods anySatisfy: [:m | m isAbstract]) ifTrue: [^Color blue].
	(aClass superclass = TestCase ) ifTrue: [ ^Color orange ].
	(aClass class includesSelector: #confluenceSetup)  ifTrue: [ ^Color cyan ].
	^Color black
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> colorForMethod: aCompiledMethod [
	aCompiledMethod isAbstract ifTrue: [^Color yellow].
	aCompiledMethod isTestMethod ifTrue: [ ^Color orange ].
	(aCompiledMethod referencedClasses includes: GtMondrian) ifTrue: [ ^Color cyan ].
	aCompiledMethod isGTExampleMethod ifTrue: [ ^Color lightOrange  ].
	(self isAccessor: aCompiledMethod) ifTrue: [ ^Color blue ].
	(aCompiledMethod hasPragmaNamed: #gtView) ifTrue: [^Color lightGreen].
	(aCompiledMethod hasPragmaNamed: #magritteDescription) ifTrue: [^Color lightBlue].
	(aCompiledMethod hasPragmaNamed: #gtExample) ifTrue: [^Color brown].
	^Color green
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> findOrNewBoundedContext: aString [ 
	^ boundedContexts at: aString ifAbsentPut: [MMBoundedContext named: aString].
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> initialize [
	boundedContexts := Dictionary new
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> isAccessor: aCompiledMethod [
	^(self isSimpleGetter: aCompiledMethod) or: [self isSimpleSetter: aCompiledMethod]
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> isSimpleGetter: aMethod [ 
	"Only a method directly returning an instance variable"
	^  (aMethod ast statements size = 1) and: 
		[ aMethod ast statements first isReturn  and: 
		[ aMethod ast statements first value isVariable] ]

]

{ #category : #'as yet unclassified' }
MMModularMonolith >> isSimpleSetter: aMethod [ 
	"Only a method directly returning an instance variable"
	^  (aMethod ast statements size = 1) and: 
		[ aMethod ast statements first isAssignment  and: 
		[ aMethod ast statements first variable isVariable] ]
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> kernelModel [
	<gtExample>
	^self packageViewIncluding: MMModularMonolith
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> magritteModel [
	<gtExample>
	^self packageViewIncluding: MABasicObject prefix: 'MA'
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> packageViewIncluding: aClass [
	| view tags|
	view := GtMondrian new.
	tags := (RPackageOrganizer default globalPackageOf: aClass) classTags 
		removeAllSuchThat: [ :e | e name = 'Manifest'].
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withDefaultContainer 
			label: (each name) asString ];
		with: tags;
		forEach: [:tag | view nodes 
			shape: [ :cl | GtMondrianUMLClassElement withDefaultContainer 
				label: (cl) asString;
				labelAttributes: {BlTextForegroundAttribute paint:(self colorForClass: cl)} ];
			with: (tag classes sorted: [:a :b | a name < b name]);
				forEach: [:cla | view nodes 
					shape: [ :me | BlElement new 
						background: (self colorForMethod: me);
						border: (BlBorder paint: Color gray);
						size: (5 max: 2* me linesOfCode) @ (5 max: 2* me numLiterals);
						yourself  ];
			with: ((cla methods) sorted: [ :a :b | a selector < b selector ]).
			view layout rectanglePack  ]] in: #default.
	view layout rectanglePack.
	^ view
]

{ #category : #'as yet unclassified' }
MMModularMonolith >> packageViewIncluding: aClass prefix: aPrefix [
	| view tags|
	view := GtMondrian new.
	tags := (RPackageOrganizer default globalPackageOf: aClass) classTags 
		removeAllSuchThat: [ :e | e name = 'Manifest'].
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withDefaultContainer 
			label: (each name) asString ];
		with: tags;
		forEach: [:tag | view nodes 
			shape: [ :cl | GtMondrianUMLClassElement withDefaultContainer 
				label: ((cl) asString withoutPrefix: aPrefix);
				labelAttributes: {BlTextForegroundAttribute paint:(self colorForClass: cl)} ];
			with: (tag classes sorted: [:a :b | a name < b name]);
				forEach: [:cla | view nodes 
					shape: [ :me | BlElement new 
						background: (self colorForMethod: me);
						border: (BlBorder paint: Color gray);
						size: (5 max: 2* me linesOfCode) @ (5 max: 2* me numLiterals);
						yourself  ];
			with: ((cla methods) sorted: [ :a :b | a selector < b selector ]).
			view layout rectanglePack  ]] in: #default.
	view layout rectanglePack.
	^ view
]
