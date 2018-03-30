# PokerHandApp
Poker Hand App
Bare Minimum:

Fun Coding Challenge with API's and MVVM Design Pattern:

* Create Github account and a public repository called PokerHandApp. Commit your work there.
* In xCode, create a new single project and embed the initial view controller in a navigation controller
* The initial View Controller should simply display a centered button which would create a deck of cards when pressed (Step 1), and then push to a new View Controller displaying the card images in a collection view (Step 2).
* Display Activity Indicator when doing network calls.
* Create all View Controllers in a MVVM architecture.
\\\\\
Documentation:
1. Create Deck of cards (obtain a deck_id)
https://deckofcardsapi.com/api/deck/new/
2. Display All 52 card images in a UICollectionView
https://deckofcardsapi.com/api/deck/<<deck_id>>/draw/?count=52
3. Objective is to select 5 cards for your own poker hand from the card images you display in the collection view. When the user selects a card image, the functionality should modally display an image preview and the choice to add the card to your “poker hand array” or to dismiss the modal. If the card image is added to the array simply dismiss the modal right after.
4. Add a top right navigation bar button item that would modally display the current cards in your “poker hand”. This time use a UITableView with a custom cell displaying the cards image, value and suit.
BONUS: Functionality to delete cards from you Poker Hand!

