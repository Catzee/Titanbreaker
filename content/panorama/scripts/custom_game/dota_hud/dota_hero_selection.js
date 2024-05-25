function GetDotaHudRoot()
{
    return $.GetContextPanel().GetParent().GetParent().GetParent();
}

(function() {
    let dotaHudRoot = GetDotaHudRoot();
    
    if(dotaHudRoot == undefined) {
        return;
    }

    // Disables dire heroes display (always empty)
    let direHeroes = dotaHudRoot.FindChildTraverse("DireTeamPlayers");
    if(direHeroes != undefined) {
        direHeroes.style.visibility = "collapse";
    } else
    {
        $.Msg("Valve break something or did major changes to UI (can't find dire heroes panel).");
    }

    // Disables dire coach display (always empty)
    let direCoach = dotaHudRoot.FindChildTraverse("DireCoachPlayer");
    if(direCoach != undefined) {
        direCoach.style.visibility = "collapse";
    } else
    {
        $.Msg("Valve break something or did major changes to UI (can't find dire coach panel).");
    }
    
    // Swaps timer label and radiant heroes (looks better)
    let timerLabel = dotaHudRoot.FindChildTraverse("HeaderCenter");
    if(timerLabel != undefined) {
        // Less spacing looks better
        timerLabel.style.width = "125px";
        let container = timerLabel.GetParent();
        let radiantHeroes = dotaHudRoot.FindChildTraverse("RadiantTeamPlayers");
        if(radiantHeroes != undefined) {
            container.MoveChildAfter(radiantHeroes, timerLabel);
        } else
        {
            $.Msg("Valve break something or did major changes to UI (can't find radiant players).");
        }
    } else
    {
        $.Msg("Valve break something or did major changes to UI (can't find timer panel).");
    }

    /*
    // Doesn't work until at least one hero selected so disabled for now
    // Disabled aghs and innate ability icons
    let heroInspectContainer = dotaHudRoot.FindChildTraverse("HeroInspect");

    if(heroInspectContainer != undefined) {
        let heroAbilitiesPanel = dotaHudRoot.FindChildTraverse("HeroAbilities");
        if(heroAbilitiesPanel != undefined) {
            let childsCount = heroAbilitiesPanel.GetChildCount();

            for(let i = 0; i < childsCount; i++) {
                let child = heroAbilitiesPanel.GetChild(i);
    
                if(child == undefined) {
                    break;
                }
    
                if(child.paneltype === "DOTAInnateIcon" || child.BHasClass("ScepterDetails")) {
                    child.style.visibility = "collapse";
                }
            }
        } else
        {
            $.Msg("Valve break something or did major changes to UI (can't hero abilities in hero summary panel).");
        }
    } else
    {
        $.Msg("Valve break something or did major changes to UI (can't hero summary panel).");
    } */
})();