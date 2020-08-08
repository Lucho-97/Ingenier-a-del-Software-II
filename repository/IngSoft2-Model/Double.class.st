Class {
	#name : #Double,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Double >> activateCardEffectIn: aGame [
	aGame playTurnFor: (aGame currentPlayer)
]
