Class {
	#name : #GameTestWithCards,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'extract methods' }
GameTestWithCards >> createAccelerationCardsGenerator [
	| deck  aCardGenerator |
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Acceleration new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createDoubleCardsGenerator [
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Double  new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createOverloadCardsGenerator [
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Overload new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createRepeatCardsGenerator [
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Repeat new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createReverseCardsGenerator [ 
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Reverse new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createSkipCardsGenerator [
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Skip  new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createSpeedCardsGenerator [ 
	| deck  aCardGenerator |	
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: Speed new ].
	aCardGenerator := DeterministicDeck withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardAffectsTurnOfPlayer [
	| board john tim players dice dices game acceleration1 deck |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createAccelerationCardsGenerator.
	acceleration1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handOf: john) size equals: 2.
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 7.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game activePermanentCardsfor: john)size equals: 1.
	self assert: (game activePermanentCardsfor: tim)size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardIsCancelled [
	| board john tim players dice dices game deck acceleration1 acceleration2 acceleration3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (acceleration1 := Acceleration new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (acceleration2 := Acceleration new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (acceleration3 := Acceleration new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	game playCard: cancellation1 fromPlayer: john forCard: acceleration1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 0
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardIsRedone [
	| board john tim players dice dices game deck acceleration1 acceleration2 acceleration3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (acceleration1 := Acceleration new).
	deck add: (redo1 := Redo new).
	deck add: (acceleration2 := Acceleration new).
	deck add: (redo2 := Redo new).
	deck add: (acceleration3 := Acceleration new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game playCard: redo2 fromPlayer: tim.
	self assert: (game activePermanentCardsfor: john) size equals: 2.
	self assert: (game activePermanentCardsfor: tim) size equals: 2
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardIsRemovedFromHand [
	| board john tim players dice dices game deck acceleration1 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createAccelerationCardsGenerator.
	acceleration1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	self assert: (game activePermanentCardsfor: tim) size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testCancellationCardIsRedone [
	| board john tim players dice dices game deck overload1 overload2 cancellation1 redo1 |
	deck := OrderedCollection new.
	deck add: (overload1 := Overload new).
	deck add: (overload2 := Overload new).
	deck add: (redo1 := Redo new).
	deck add: (cancellation1 := Cancellation new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	self assert: (game handOf: tim) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	game playCard: overload2 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 0.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 2.
	game playCard: cancellation1 fromPlayer: tim forCard: overload1.
	game playCard: redo1 fromPlayer: tim forCard: overload2.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 0
]

{ #category : #tests }
GameTestWithCards >> testCancellationWithNoCardsActivated [
	| board john tim players dice dices game deck acceleration1 acceleration2 acceleration3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (acceleration1 := Acceleration new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (acceleration2 := Acceleration new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (acceleration3 := Acceleration new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	self
		should: [ game playCard: cancellation1 fromPlayer: john forCard: acceleration1 ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cancellation requires an active permanent card to cancel' ].
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	game playCard: cancellation1 fromPlayer: john forCard: acceleration1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 0
]

{ #category : #tests }
GameTestWithCards >> testCardsAreNotPlayableAfterGameEnds [
	| board john tim players dice dices game deck overload1 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createOverloadCardsGenerator.
	overload1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 11.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self assert: (game spaceOf: john) equals: 10.
	self assert: (game lapOf: john) equals: 1.
	self assert: (game spaceOf: tim) equals: 4.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: tim.
	game turnOf: john.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: (game spaceOf: john) equals: 4.
	self assert: (game lapOf: john) equals: 2.
	self assert: (game spaceOf: tim) equals: 5.
	self assert: (game lapOf: tim) equals: 0.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: game hasEnded.
	self
		should: [ game playCard: overload1 fromPlayer: john forPlayer: tim ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cards can not be played after the game has ended' ]
]

{ #category : #tests }
GameTestWithCards >> testDoubleCardIsUsed [
	| board john tim players dice dices game deck double1 double2 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createDoubleCardsGenerator.
	double1 := deck cards at: 1.
	double2:= deck cards at: 3.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: double1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 7.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 6.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: double2 fromPlayer: tim.
	self assert: (game spaceOf: john) equals: 8.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 6.
	self assert: (game lapOf: tim) equals: 0.
]

{ #category : #tests }
GameTestWithCards >> testGameWithCardsIsCreated [
	| board john tim players dice dices game |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: self createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded
]

{ #category : #tests }
GameTestWithCards >> testGameWithRandomCardsIsCreated [
	| board john tim players dice dices game |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: RandomDeck new
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: ((game handOf: john) allSatisfy: [ :card | Card allSubclasses includes: card class ])
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardAffectsTurnOfPlayer [
	| board john tim players dice dices game deck overload1 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createOverloadCardsGenerator.
	overload1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handOf: john) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 11.
	self assert: (game lapOf: tim) equals: -1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardIsCancelled [
	| board john tim players dice dices game deck overload1 overload2 overload3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (overload1 := Overload new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (overload2 := Overload new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (overload3 := Overload new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game playCard: cancellation2 fromPlayer: tim forCard: overload1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 0
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardIsRedone [
	| board john tim players dice dices game deck overload1 overload2 overload3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (overload1 := Overload new).
	deck add: (redo1 := Redo new).
	deck add: (overload2 := Overload new).
	deck add: (redo2 := Redo new).
	deck add: (overload3 := Overload new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game playCard: redo2 fromPlayer: tim forPlayer: tim.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 2
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardIsRemovedFromHand [
	| board john tim players dice dices game deck overload1 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createOverloadCardsGenerator.
	overload1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testPermanentCardInOtherPlayerTurn [
	| board john tim players dice dices game deck acceleration1 acceleration3 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createAccelerationCardsGenerator.
	acceleration1 := deck cards at: 1.
	acceleration3 := deck cards at: 3.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	self
		should: [ game playCard: acceleration3 fromPlayer: tim ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Permanent Cards can only be played in the player´s turn' ].
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	self assert: (game activePermanentCardsfor: tim) size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testPlayerDrawsCardFromTile [
	| board john tim players dice dices game deck acceleration1 |
	board := Board composedOf: GameTestWithoutCards new createTilesDrawACardTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createAccelerationCardsGenerator.
	acceleration1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: acceleration1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 1.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game turnOf: john.
	self assert: (game handOf: john) size equals: 2
]

{ #category : #tests }
GameTestWithCards >> testPlayerPlaysCardHeDoesNotHave [
	| board john tim players dice dices game deck overload1 overload2 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createOverloadCardsGenerator.
	overload1 := deck cards at: 1.
	overload2 := deck cards at: 2.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: overload1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game handOf: tim) size equals: 2.
	game playCard: overload2 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 0.
	self
		should: [ game playCard: overload1 fromPlayer: john forPlayer: tim ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The player does not possess a card' ]
]

{ #category : #tests }
GameTestWithCards >> testRedoCardWithNoCardsActivated [
	| board john tim players dice dices game deck repeat1 repeat2 repeat3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (repeat1 := Repeat new).
	deck add: (redo1 := Redo new).
	deck add: (repeat2 := Repeat new).
	deck add: (redo2 := Redo new).
	deck add: (repeat3 := Repeat new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	game drawCardForPlayer: tim.
	game drawCardForPlayer: tim.
	self assert: (game handOf: john) size equals: 2.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: redo2 fromPlayer: tim forPlayer: john.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0
]

{ #category : #tests }
GameTestWithCards >> testRepeatCardIsRedone [
	| board john tim players dice dices game deck repeat1 repeat2 repeat3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (repeat1 := Repeat new).
	deck add: (redo1 := Redo new).
	deck add: (repeat2 := Repeat new).
	deck add: (redo2 := Redo new).
	deck add: (repeat3 := Repeat new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game turnOf: john.
	self assert: (game spaceOf: john) equals: 2.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: repeat2 fromPlayer: tim.
	self assert: (game spaceOf: john) equals: 18.
	self assert: (game lapOf: john) equals: -1.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handOf: john) size equals: 2.
	game playCard: redo2 fromPlayer: tim .
	self assert: (game spaceOf: john) equals: 14.
	self assert: (game lapOf: john) equals: -1.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handOf: john) size equals: 2
]

{ #category : #tests }
GameTestWithCards >> testRepeatCardIsUsed [
	| board john tim players dice dices game deck repeat1 repeat2 |
	board := Board composedOf: GameTestWithoutCards new createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createRepeatCardsGenerator.
	repeat1 := deck cards at: 1.
	repeat2 := deck cards at: 2.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	game playCard: repeat1 fromPlayer: john.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	game turnOf: john.
	self assert: (game spaceOf: john) equals: 2.
	self assert: (game lapOf: john) equals: 0.
	game playCard: repeat2 fromPlayer: john.
	self assert: (game spaceOf: john) equals: 18.
	self assert: (game lapOf: john) equals: -1
]

{ #category : #tests }
GameTestWithCards >> testRepeatCardWithNoTilesActivated [
	| board john tim players dice dices game deck repeat1 repeat2 repeat3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (repeat1 := Repeat new).
	deck add: (redo1 := Redo new).
	deck add: (repeat2 := Repeat new).
	deck add: (redo2 := Redo new).
	deck add: (repeat3 := Repeat new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: repeat2 fromPlayer: tim.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0
]

{ #category : #tests }
GameTestWithCards >> testReverseCardIsUsed [
	| board john tim bob poly players dice dices game deck reverse1 reverse2 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	bob := 'Bob'.
	poly := 'Poly'.
	players := Array with: john with: tim with: bob with: poly.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createReverseCardsGenerator.
	reverse1 := deck cards at: 1.
	reverse2:= deck cards at: 2.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.	
	self assert: (game spaceOf: bob) equals: 1.
	self assert: (game lapOf: bob) equals: 0.
	self assert: (game spaceOf: poly) equals: 1.
	self assert: (game lapOf: poly) equals: 0.
	self assert: (game currentPlayer) equals: 'John'.
	game playCard: reverse1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game currentPlayer) equals: 'Poly'.
	game turnOf: poly.
	self assert: (game spaceOf: poly) equals: 6.
	game turnOf: bob.
	self assert: (game spaceOf: bob) equals: 2.
	self assert: (game currentPlayer) equals: 'Tim'.
	game playCard: reverse2 fromPlayer: john.
	self assert: (game currentPlayer) equals: 'Bob'.
	game turnOf: bob.
	game turnOf: poly.
	game turnOf: john.
]

{ #category : #tests }
GameTestWithCards >> testSkipCardIsUsed [
	| board john tim players dice dices game deck skip1 skip2 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createSkipCardsGenerator.
	skip1 := deck cards at: 1.
	skip2:= deck cards at: 2.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game playCard: skip1 fromPlayer: john.
	self assert: (game handOf: john) size equals: 1.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 6.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
		game assert: (game currentPlayer) = 'Tim'.
	game playCard: skip2 fromPlayer: john.
	game assert: (game currentPlayer) = 'John'.
	game turnOf: john.
	self assert: (game spaceOf: john) equals: 7.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 6.
	self assert: (game lapOf: tim) equals: 0.

]

{ #category : #tests }
GameTestWithCards >> testSpeedCardAffectsTurnOfPlayer [
	| board john tim players dice dices game deck speed1 |
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createSpeedCardsGenerator.
	speed1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game spaceOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handOf: john) size equals: 2.
	game playCard: speed1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game spaceOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game spaceOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardIsCancelled [
	| board john tim players dice dices game deck speed1 speed2 speed3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (speed1 := Speed new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (speed2 := Speed new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (speed3 := Speed new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: speed1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game playCard: cancellation2 fromPlayer: tim forCard: speed1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 0
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardIsRedone [
	| board john tim players dice dices game deck speed1 speed2 speed3 redo1 redo2 redo3 |
	deck := OrderedCollection new.
	deck add: (speed1 := Speed new).
	deck add: (redo1 := Redo new).
	deck add: (speed2 := Speed new).
	deck add: (redo2 := Redo new).
	deck add: (speed3 := Speed new).
	deck add: (redo3 := Redo new).
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: (DeterministicDeck withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: speed1 fromPlayer: john forPlayer: tim.
	self assert: (game handOf: john) size equals: 1.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 1.
	game playCard: redo2 fromPlayer: tim forPlayer: tim.
	self assert: (game activePermanentCardsfor: john) size equals: 0.
	self assert: (game activePermanentCardsfor: tim) size equals: 2
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardIsRemovedFromHand [
	| board john tim players dice dices game deck speed1|
	board := Board composedOf: GameTestWithoutCards new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	deck := self createSpeedCardsGenerator.
	speed1 := deck cards at: 1.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		usingDeck: deck
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handOf: john) size equals: 2.
	game playCard: speed1 fromPlayer: john forPlayer: john.
	self assert: (game handOf: john) size equals: 1
]
