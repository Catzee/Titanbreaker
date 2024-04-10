		function GameModeVote(mode)
		{
			$.Msg( "GameModeAllPick");
			GameEvents.SendCustomGameEventToServer( "gamemode_vote", { "player_id" : Players.GetLocalPlayer(), "mode_id" : mode } );
			$.FindChildInContext("#startbuttons").visible = false;
		}
		function RoundsToWinVote(wins)
		{
			$.Msg( "GameModeAllPick");
			GameEvents.SendCustomGameEventToServer( "gamemode_vote", { "player_id" : Players.GetLocalPlayer(), "mode_id" : wins } );
			$.FindChildInContext("#startbuttons").visible = false;
		}
		function ArenaStartVote(vote)
		{
			$.Msg( "ArenaStartVote");
			GameEvents.SendCustomGameEventToServer( "gamemode_vote", { "player_id" : Players.GetLocalPlayer(), "mode_id" : vote } );
			$.FindChildInContext("#startbuttons").visible = false;
		}