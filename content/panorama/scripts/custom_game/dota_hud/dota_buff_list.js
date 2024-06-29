let BUFF_LIST_CHILDRENS_PER_ROW = 12;
let BUFF_LIST_MAX_ROWS = 4;
let BUFF_LIST_INITIAL_CHILDRENS = BUFF_LIST_MAX_ROWS * BUFF_LIST_CHILDRENS_PER_ROW;
let BUFF_LIST_TICKRATE = 0.05;

function GetLocalPlayerSelectedUnit() {
    let selectedUnit = Players.GetQueryUnit(Game.GetLocalPlayerID())
    if(selectedUnit < 0) {
        selectedUnit = Players.GetLocalPlayerPortraitUnit()
    }
    return selectedUnit;
}

function UpdateBuffs(panel, isBuffs)
{
    // No idea why it may rarely fail and throw exception (hopefully its one time bug and try catch will fix that)
    try
    {
        let selectedUnit = GetLocalPlayerSelectedUnit();
        let buffSerialsToUse = [];
    
        for(let i = 0; i <= Entities.GetNumBuffs(selectedUnit); i++)
        {
            let buffSerial = Entities.GetBuff(selectedUnit, i);
    
            if(buffSerial < 0) {
                break;
            }
    
            let isSkip = Buffs.IsDebuff(selectedUnit, buffSerial) == isBuffs;
    
            if(isSkip) {
                continue;
            }
    
            let isHidden = Buffs.IsHidden(selectedUnit, buffSerial);
    
            if(isHidden) {
                continue;
            }
    
            let modifierName = Buffs.GetName(selectedUnit, buffSerial);
            let isBrokenModifier = modifierName == undefined || modifierName.length < 1;
    
            if(isBrokenModifier) {
                continue;
            }
    
            buffSerialsToUse.push(buffSerial);
        }
        
        for(let i = 0; i < BUFF_LIST_INITIAL_CHILDRENS; i++) {
            if(buffSerialsToUse[i] != undefined) {
                panel._childrens[i].SetHasClass("Hidden", false);
                UpdateBuffPanel(panel._childrens[i], selectedUnit, buffSerialsToUse[i]);
            } else
            {
                panel._childrens[i].SetHasClass("Hidden", true);
            }
        }
    } catch (e)
    {
        $.Msg(e);
    }

    $.Schedule(BUFF_LIST_TICKRATE, function() {
        UpdateBuffs(panel, isBuffs);
    });
}

function UpdateBuffPanel(panel, selectedUnit, buffSerial)
{
    let stacksCount = Buffs.GetStackCount(selectedUnit, buffSerial);
    let textureName = Buffs.GetTexture(selectedUnit, buffSerial);
    let buffAbility = Buffs.GetAbility(selectedUnit, buffSerial);
    let isItem = Abilities.IsItem(buffAbility);
    let isCustomIcon = textureName.indexOf("fix/") !== -1;
    let pathToIcon = "";
        
    panel.SetHasClass("is_item", false);

    if(isCustomIcon) {
        if(isItem) {
            textureName = textureName.replace("item_", "");
            pathToIcon = "raw://resource/flash3/images/items/" + textureName + ".png";
        } else {
            pathToIcon = "raw://resource/flash3/images/spellicons/" + textureName + ".png";
        }
    } else {
        if(isItem && textureName.indexOf("item_") !== -1) {
            panel.SetHasClass("is_item", true);
            panel._itemImagePanel.itemname = Abilities.GetAbilityName(buffAbility);
            //textureName = textureName.replace("item_", "");
        }
        pathToIcon = "file://{images}/spellicons/" + textureName + ".png";
    }

    //panel.SetHasClass("is_custom", isCustomIcon);
    //panel.SetHasClass("is_item", isItem);
    //panel.SetHasClass("is_ability", !isItem);

    panel._queryUnit = selectedUnit;
    panel._buffSerial = buffSerial;

    panel.SetHasClass("has_stacks", stacksCount > 0);

    panel._stacksLabel.text = stacksCount;
    panel._imagePanel.SetImage(pathToIcon);
    var buffDurationDeg = Math.max(0, 360 * (Buffs.GetRemainingTime(selectedUnit, buffSerial) / Buffs.GetDuration(selectedUnit, buffSerial)))
	if(Buffs.GetDuration(selectedUnit, buffSerial) == -1 || Buffs.GetRemainingTime(selectedUnit, buffSerial) < 0) { 
        buffDurationDeg = 360; 
    }
    buffDurationDeg *= -1;
	panel._durationPanel.style.clip = "radial(50% 50%, 0deg, " + buffDurationDeg + "deg)";
}

function InitializeChildrens(panel, isBuffs)
{
    panel.RemoveAndDeleteChildren();
    panel._childrens = [];

    for (let i = 0; i < BUFF_LIST_INITIAL_CHILDRENS; i++) {
        let buffPanel = $.CreatePanel('Panel', panel, '');
        buffPanel.SetHasClass("DOTABuff", true);
        buffPanel.SetHasClass("is_debuff", !isBuffs);
        buffPanel.SetHasClass("Hidden", true);
        buffPanel.SetHasClass("is_undispellable", true); // looks better with it and no way to get this at panorama...
        buffPanel.BLoadLayout('file://{resources}/layout/custom_game/dota_hud/dota_buff.xml', false, false);
        buffPanel._imagePanel = buffPanel.FindChildTraverse("BuffImage");
        buffPanel._itemImagePanel = buffPanel.FindChildTraverse("BuffItemImage");
        buffPanel._stacksLabel = buffPanel.FindChildTraverse("StackCount");
        buffPanel._durationPanel = buffPanel.FindChildTraverse("CircularDuration");
        buffPanel._queryUnit = -1;
        buffPanel._buffSerial = -1;
        buffPanel.SetPanelEvent(
            "onmouseover", 
            function() {
                $.DispatchEvent("DOTAShowBuffTooltip", buffPanel, buffPanel._queryUnit, buffPanel._buffSerial, Entities.IsEnemy(buffPanel._queryUnit));
            });
            buffPanel.SetPanelEvent(
            "onmouseout", 
            function() {
                $.DispatchEvent("DOTAHideBuffTooltip", buffPanel);
            })
        panel._childrens.push(buffPanel);
    }

    let buffWidth = 40;
    let buffHeightMargin = 2;
    let buffHeight = 40 + buffHeightMargin;
    let buffMargins = 4;
    let bandAidFix = 5;
    panel.style.maxWidth = ((BUFF_LIST_CHILDRENS_PER_ROW * (buffWidth + buffMargins)) + bandAidFix) + "px";
    panel.style.height = (BUFF_LIST_MAX_ROWS * buffHeight) + "px";

    $.Schedule(BUFF_LIST_TICKRATE, function() {
        UpdateBuffs(panel, isBuffs);
    });
}

(function() {
    let container = $.GetContextPanel();
    InitializeChildrens(container, container.BHasClass("customBuffs"));
})();