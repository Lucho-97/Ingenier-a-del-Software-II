Class {
	#name : #Tile,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Tile >> activateEffectforIn: aGame forPlayer: aPlayer [
	self subclassResponsibility
]
