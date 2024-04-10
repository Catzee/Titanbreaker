function TempleVote()
{ 
    $.Msg("vote difficulty");
}


(function () {
    $.Msg("temple vote difficulty loaded");
    if (Game.GetMapInfo()['map_display_name'] == "beginner_dungeon_crawler"){
        $.FindChildInContext("#votepanel").visible = true;
    }
})();