extends Node

enum PlayerState {
	EMPTY,
	RUNNING,
	DASHING,
	JUMPING,
	SLIDING
}

var current_state : PlayerState = PlayerState.RUNNING
