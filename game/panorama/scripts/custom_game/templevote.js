"use strict";

function LoadTopPlayersFromServer()
{   
    $.AsyncWebRequest('http://catze.eu/templetop10_season_10.php',
    {
        type: 'POST',
        data: { order: "gettop10"
                },
        success: function (data) {
            //$.Msg('TopPlayerDataReceive: ', data)
            LeaderboardTopPlayersFill(data);
        }
    });
}

function LeaderboardTopPlayersFill(data) {
    //$.Msg('TopPlayerDataFill:');
    $("#playerleaderboard").html = true;
    $("#playerleaderboard").text = data;
}

function TempleVote(args)
{ 
    $.Msg("vote difficulty");
    if(args == -1 || args == 1){
    	GameEvents.SendCustomGameEventToServer( "temple_difficulty_change", { value: args} );
    }
}

function NextTip() {
    $("#loadingscreen_tips").text = RandomTip();
}

function RandomTip() {
    var max_tips = 20;
    var tip = new Array(max_tips);
    tip[0] = "There are 11 Acts. Each Act will be 10% harder than the one before, but also Item drop quality will rise.";
    tip[1] = "Act 11 is the final Act. It consists of 10 encounters.\nOne encounter is unlocked whenever you finish one of the first 10 Acts.\nAfter 10 unlocks, you meet the final encounter.";
    tip[2] = "Try not to die, because you only have 5 lives.\nWhen all lives are gone, you will not be revived.";
    tip[3] = "This game is about cooperation and occupying all roles:\nYou need a Tank to hold aggro and mitigate all incoming Damage to protect his team.\nYou need a Healer to keep wounded allies alive and dispel debuffs.\nYou need Damage Dealers to kill and control Bosses and Monsters.";
    tip[4] = "Read all Boss Abilities before engaging.\nMany Abilities and Effects can be dodged, making the life of your Healer much easier.\nYou can also click the Boss during the fight, to the cooldowns of his Abilities for anticipation.";
    tip[5] = "When you have trouble finding a group of 5, try playing with less players on 100% or 50% difficulty.\nThis is the only difficulty where playing with less players reduces Monster health by 18% and Damage by 10% per missing player.";
    tip[6] = "At Level 10 you unlock your Path, giving access to a wide range of passive bonuses.";
    tip[7] = "When you start a new game, your character will automatically load, if you did save it in a previous game.\nBut your Ability and Path Points will also be reset, so you can respec every game, adopting to your team setup.";
    tip[8] = "Each Boss of Act 11 drops an exclusive [Ancient] Immortal Item,\n only obtainable at that specific encounter.";
    tip[9] = "Artifacts are powerful Items giving you additional bonuses, similar to your normal 6 slot Inventory.\nThey start dropping as Epic drops, but also exist in Legendary and Immortal quality.";
    tip[10] = "Immortal Items start dropping on 1000% difficulty.";
    tip[11] = "There are many Quests you can do to get extra rewards.\nCheck out the Riders of Hope at the beginning of Act 3 to read about all Quests.";
    tip[12] = "The Info Tab on the top left has a lot of extra Information in case you are interested in additional details.";
    tip[13] = "You can check out the Leaderboard with the best players on www.catze.eu/temple.php\nYou can also visit our Forum on that page, if you have suggestions or found a bug.";
    tip[14] = "If you find the Menu on the left disturbing, you can toggle most elements of it on and off by clicking the headlines.";
    tip[15] = "Most Ability Damage modifiers work multiplicatively.\nExceptions are passive Ability Damage % buffs, which stack additively.\nThe same counts for all bonuses based on Damage type (for example Fire Damage or Physical Damage).";
    tip[16] = "Join the Temple of Dreams Chat to find a party to play with.";
    tip[17] = "Legendary non-Set Items can be bought for Gold at the Smith in the starting location.\nCheck out his Items, some are very powerful.\nGold is gained by selling Items you do not need or by doing Quests.";
    tip[18] = "Some Heroes do not use Mana but have a custom Resource System instead.\nThis includes the classes Brawler, Shadowstalker, Deathbringer, Ranger, Demonslayer and Wild Guardian.\nRead your Abilities carefully to understand how it works.";
    tip[19] = "In Challenge Mode you always start with a level 1 Hero with no Items and a new Leaderboard tracks how much you can progress in a single game.\nYou can check out the Top 100 Players here: http://catze.eu/temple_ranking_challenge_mode.php";

    return tip[getRandomInt(0,max_tips-1)];
}

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min +1)) + min; 
}

function SetTempleDifficulty(args)
{ 
	var value = "Monster Level: ";
    var chance = Math.round(args.value*100)/100; // * 100;
    var scalefactor = 1.25; //1.75*1.1;
    value = value.concat((String)(chance));
    //value = value.concat("%");
    //$.Msg($("#diffiselection"));
    if($("#diffiselection") != null){
        $("#diffiselection").text = value;
    }
    chance = args.value * 100;

    chance = 0.0005*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    if (args.value < 100.0){
        chance = 0.0;
    }
    chance = chance.toFixed(2);
    value = (String)(chance);
    value = value.concat("%");
    $("#divine2").text = value;

    chance = 0.05*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    if (args.value < 5.0){
        chance = 0.0;
    }
    chance = chance.toFixed(2);
    value = (String)(chance);
    value = value.concat("%");
    $("#immortal2").text = value;
    chance = 0.5*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    if (args.value < 1.0){
        chance = 0.0;
    }
    chance = chance.toFixed(2);
    value = (String)(chance);
    value = value.concat("%");
    $("#legendary2").text = value;
    chance = 3*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    if (args.value < 1.0){
        chance = 0.0;
    }
    chance = chance.toFixed(1);
    value = (String)(chance);
    value = value.concat("%");
    $("#epic2").text = value;
    chance = 10*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    chance = chance.toFixed(1);
    value = (String)(chance);
    value = value.concat("%");
    $("#rare2").text = value;
    chance = 25*(args.value*scalefactor-(scalefactor-1));
    if (chance > 100.0){
        chance = 100;
    }
    chance = chance.toFixed(0);
    value = (String)(chance);
    value = value.concat("%");
    $("#common2").text = value;
    chance = exp_scale(args.value, 100, 0.15); //(3 * args.value - 2) * 100;                 //exp_scale(args.value, 100);
    if (chance < 25){
        chance = 25;
    }
    chance = chance.toFixed(1);
    value = (String)(chance);
    value = value.concat("%");
    $("#Exp2").text = value;

    $("#hardmode").text = "";
    if (args.value == 2){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>";
    }
    if (args.value == 5){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>";
    }
    if (args.value == 10){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<";
    }
    if (args.value == 20){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<br>● [Ancient] Immortals added to Immortal Drop Table";
    }
    if (args.value == 50){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<br>● [Ancient] Immortals added to Immortal Drop Table<br>● [Ancient] Immortal Sets and Temple Shards added to Immortal Drop Table";
    }
    if (args.value == 100){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<br>● [Ancient] Immortals added to Immortal Drop Table<br>● [Ancient] Immortal Sets and Temple Shards added to Immortal Drop Table<br>● [Divine] Items can drop";
    }
    if (args.value == 200){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<br>● [Ancient] Immortals added to Immortal Drop Table<br>● [Ancient] Immortal Sets and Temple Shards added to Immortal Drop Table<br>● [Divine] Items can drop<br>● [Mythical] Items and Artifacts can drop";
    }
    if (args.value == 500){
        $("#hardmode").text = "<br>● [Ancient] Legendaries added to Legendary Drop Table<br>● Immortal Items can drop<br>● Immortal Set Items added to Immortal Drop Table<br>● [Ancient] Immortals added to Immortal Drop Table<br>● [Ancient] Immortal Sets and Temple Shards added to Immortal Drop Table<br>● [Divine] Items can drop<br>● [Mythical] Items and Artifacts can drop<br>● Artifact Amulets and Mythical Set Tokens can drop. Only 1 Life!";
    }

    $.Msg(args.value);
    //if (args.value < 10.0){
    //    $("#hardmode").text = "";
    //    $("#tipmessages").visible = true;
    //}else{
    //    $("#tipmessages").visible = false;
    //}
    /*
    if (args.value >= 10.0){
        $("#hardmode").text = "Advanced Mode:<br>Improved Monster (10%) and Boss (20%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>100% higher Boss Auto Attack Damage<br>Immortal Items can drop";
    }
    if (args.value >= 20.0){
        $("#hardmode").text = "Advanced Mode:<br>Improved Monster (10%) and Boss (20%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>100% higher Boss Auto Attack Damage<br>Immortal Items can drop<br>Artifact Chest Armor can drop";
    }
    if (args.value >= 30.0){
        $("#hardmode").text = "Hard Mode:<br>Improved Monster (10%) and Boss (20%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>100% higher Boss Auto Attack Damage<br>Harder Boss Abilities<br>More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop";
    }
    if (args.value >= 40.0){
        $("#hardmode").text = "Nightmare Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Artifact Chest Armor can drop<br>Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Artifact Chest Armor can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11";
    }
    if (args.value >= 50.0){
        $("#hardmode").text = "Hell Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Immortal Artifact Boots and Chest can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Head Items can drop<br>[Ancient] Immortal Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Mythic Dust can be obtained via Quests<br>Most Teleporters unlocked from start";
    }
    if (args.value >= 75.0){
        $("#hardmode").text = "Destruction Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Immortal Artifact Boots and Chest can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Head Items can drop<br>[Ancient] Immortal Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Mythic Dust can be obtained via Quests<br>Most Teleporters unlocked from start<br>Dreamshards can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11";
    }
    if (args.value >= 100.0){
        $("#hardmode").text = "Nemesis Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Immortal Artifact Boots and Chest can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Head Items can drop<br>[Ancient] Immortal Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Mythic Dust can be obtained via Quests<br>Most Teleporters unlocked from start<br>Dreamshards can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>[Ancient] Items can drop from Act 11 and 12 Bosses, Souls can drop in Arena and Act 11";
    }
    if (args.value >= 150.0){
        $("#hardmode").text = "Trauma Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Immortal Artifact Boots and Chest can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Head Items can drop<br>[Ancient] Immortal Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Mythic Dust can be obtained via Quests<br>Most Teleporters unlocked from start<br>Dreamshards can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>[Ancient] Items can drop from Act 11 and 12 Bosses, Souls can drop in Arena and Act 11<br>[Ancient] Artifact Helm, Chest and Boots can drop from Act 11 Bosses";
    }
    if (args.value >= 200.0){
        $("#hardmode").text = "Doom Mode:<br>Improved Monster (20%) and Boss (40%) Resistances<br>Increased Boss Health and Experience<br>Hard CC on Bosses lasts shorter<br>200% higher Boss Auto Attack Damage<br>Insane Boss Abilities<br>Even More Affixes on Monsters<br>Immortal Items and Immortal 2 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Chest Armor can drop<br>Immortal Artifact Rings can drop<br>Artifact drop chance increased from 25% to 50%<br>Immortal Artifact Boots and Chest can drop<br>Immortal 3 piece Set Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Immortal Artifact Head Items can drop<br>[Ancient] Immortal Items can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>Mythic Dust can be obtained via Quests<br>Most Teleporters unlocked from start<br>Dreamshards can drop in Act 7, 8, 9 (round 4 or higher), 10 and 11<br>[Ancient] Items can drop from Act 11 and 12 Bosses, Souls can drop in Arena and Act 11<br>[Ancient] Artifact Helm, Chest and Boots can drop from Act 11 Bosses<br>[Ancient] Artifact Mainhand, Offhand and Rings can drop from Act 11 Bosses";
    }
    */
}

function exp_scale(x, xp, exp){
    return x * x * xp * exp + x * xp * (1-exp);
}

function ShowTempleDifficultyPanel(args)
{ 
    if($.FindChildInContext("#selectdiffipanel").visible){
        $.FindChildInContext("#selectdiffipanel").visible = false;
    }else{
        $.FindChildInContext("#selectdiffipanel").visible = true;
        CountdownSelection(23);
    }
    
    //$.FindChildInContext("#seq_bg").SetImage("file://{images}/custom_game/loading_screen/temple.png");
}

function CountdownSelection(time){
    if(time > 0){
        $.Schedule(1, function(){
            time = time - 1;
            if($("#TimeSelection") != null){
                $("#TimeSelection").text = "Time Remaining: ".concat((String)(time));
                CountdownSelection(time);
            }
        });
    }else{
        //$.FindChildInContext("#selectdiffipanel").visible = false;
    }
}

function LoadLeaderboardFromServerRecursive(){
    //$.Msg(Game.GetState())
    if(Game.GetState() >= DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP){
        $.Schedule(1, function(){
            LoadLeaderboardFromServerLoadingScreen();
        });
    }else{
        $.Schedule(1, function(){
            LoadLeaderboardFromServerRecursive();
        });
    }
}

function LoadLeaderboardFromServerLoadingScreen()
{   
    $.Msg("start load leaderboard");
    var ladder = Game.GetAllPlayerIDs().length;
    //$.Msg(Game.GetMapInfo()['map_display_name']);
    if (true){
        $("#leaderboardheader").text = "Titanbreaker Leaderboard";
        $.AsyncWebRequest('http://catze.eu/templetop10_season_5.php',
        {
            type: 'POST',
            data: { order: "getelo",
                    players: String(ladder)
                    },
            success: function (data) {
            $.Msg('GDS Reply: ', data)
            LeaderboardFillTemple(data);
            //return data;
        }
        });
    }
}

function LeaderboardFillTemple(data) {
    //$.Msg("starting table fill");
    //$.Msg(data);
    if($("#leaderboardloadingscreen") != null) {
        $("#leaderboardloadingscreen").visible = false; //true;
    }
    $("#d11").text = "Player";
    $("#d12").text = "Hero";
    $("#d13").text = "Boss Kill Score";
    $("#d14").visible = false;

    data = String(data);
    //$.Msg(data);
    var info = data.split(",");
    //$.Msg(info.length);
    //$.Msg("split done");
    for (var i = 0; i < info.length-1; i++) {
        //$.Msg(info[i]);

        var row = 2+Math.floor(i/4);
        var cell = 1+(i%4);
        if(cell == 4){
            continue;
        }
        var c = "#d";
        c = c.concat(String(row));
        c = c.concat(String(cell));
        //$.Msg(c);
        //$.Msg(info[i]);
        //$.Msg(basepanel.FindChild(c).value);
        if(cell == 3){
            $(c).text = info[i].concat("  -  Lives left: ").concat(info[i+1]);
        }else{
            $(c).text = info[i]; 
        }
        
        if(cell == 2){
            $(c).text = "";
            var im = "file://{images}/custom_game/heroicons/";
            im = im.concat(info[i]);
            im = im.concat(".png");
            var c = "#hero";
            c = c.concat(String(row-1));
            $.Msg(im);
            //$.Msg(c);
            $(c).SetImage(im);
        }
        if(cell == 3){
            var c = "#d";
            cell = cell + 1;
            c = c.concat(String(row));
            c = c.concat(String(cell));
            $(c).visible = false;
        }
        //$.GetContextPanel().getElementById(c).value = info[i];
    }
}


(function () {
    //$.Msg("temple vote difficulty loaded");
    //GameEvents.Subscribe("temple_difficulty_update", SetTempleDifficulty);
    //GameEvents.Subscribe("temple_show_difficulty_panel", ShowTempleDifficultyPanel); //now used to toggle
    //$.FindChildInContext("#selectdiffipanel").visible = false;
    //if (Game.GetMapInfo()['map_display_name'] != "beginner_dungeon_crawler"){
    	//$.Msg("hide select diffi panel");
    //}
    //LoadTopPlayersFromServer();
    if($("#leaderboardloadingscreen") != null) {
        $("#leaderboardloadingscreen").visible = false;
    }
    LoadLeaderboardFromServerRecursive();
    
    //$("#leaderboardloadingscreen").style.marginTop = "0px";
    //$("#leaderboardloadingscreen").style.marginLeft = "0px";
})();