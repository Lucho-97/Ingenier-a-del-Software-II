Class {
	#name : #DrawACard,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DrawACard >> activateEffectforIn: aGame forPlayer: aPlayer [
	aGame drawCardForPlayer: aPlayer
]
