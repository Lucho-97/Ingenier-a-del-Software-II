Class {
	#name : #DeterministicDeck,
	#superclass : #Deck,
	#instVars : [
		'futureCards',
		'cards',
		'currentDeckPosition'
	],
	#classInstVars : [
		'futureCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicDeck class >> withFutureCards: aCardsArray [
	^self new initializeWithFutureCards: aCardsArray.
	
]

{ #category : #accesing }
DeterministicDeck >> cards [
^cards 
]

{ #category : #actions }
DeterministicDeck >> drawCardInGame: aGame [
	currentDeckPosition := currentDeckPosition + 1.
	currentDeckPosition > cards size
		ifTrue: [ AssertionFailure signal: 'The deck is out of cards' ].
	^ cards at: currentDeckPosition
]

{ #category : #initialization }
DeterministicDeck >> initializeWithFutureCards: aCardsArray [ 
	cards := aCardsArray.
	currentDeckPosition := 0
]
