let CONTAINER = $("#LevelBackground").GetParent();
let XP_BAR = $("#CircularXPProgress");

function OnTooltip()
{
    $.DispatchEvent("DOTAShowTextTooltip", CONTAINER, $.Localize("#DOTA_HUD_Tooltip_HeroXPRange_XP", CONTAINER) + " " + XP_BAR.value + "%");
}

function OnHideTooltip()
{
    $.DispatchEvent("DOTAHideTextTooltip", CONTAINER);
}