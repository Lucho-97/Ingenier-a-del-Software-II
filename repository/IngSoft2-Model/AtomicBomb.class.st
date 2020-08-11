Class {
	#name : #AtomicBomb,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> activateEffectforIn: aGame forPlayer: aPlayer [
	aGame players do: [ :player | aGame changePositionOf: player by: (aGame positionOf: player) negated + 1 ]
]
