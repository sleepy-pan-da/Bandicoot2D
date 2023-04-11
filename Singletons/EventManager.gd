extends Node

# Event bus for distant nodes to communicate using signals.
# This is intended for cases where connecting the nodes directly creates more coupling
# or increases code complexity substantially.

# Instead of manually connecting signals, this globalscript acts as an interface to manage and pass signals 
# between different scenes. A sample use case would be the fishes. As fishes are randomly spawned,
# it will be a hassle to connect their signals to GameLevelTemplate everytime a new fish is spawned.
# This globalscript therefore helps solve this problem.


# # connected from DragAndDrop.gd to StocksToTake.gd
# signal tookStock() 

# # connected from SelectDraw.gd to Time.gd
# signal computedTimeEarnedFromDeletingBlocks(timeEarned)

signal toggle_phase()

signal collected_fruit()

signal died()