		function ChooseWeapon(weapon)
		{
			$.Msg( "WeaponChoiceClick");
			GameEvents.SendCustomGameEventToServer( "weaponchoice", { "player_id" : Players.GetLocalPlayer(), "weapon" : weapon } );
			$.FindChildInContext("#WeaponChoice").visible = false;
		}