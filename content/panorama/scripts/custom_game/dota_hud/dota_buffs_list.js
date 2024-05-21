let BUFF_LIST_CHILDRENS_PER_ROW = 13;
let BUFF_LIST_MAX_ROWS = 4;
let BUFF_LIST_INITIAL_CHILDRENS = BUFF_LIST_MAX_ROWS * BUFF_LIST_CHILDRENS_PER_ROW;

function InitializeChildrens(panel, isBuffs)
{
    panel.RemoveAndDeleteChildren();
    panel._childrens = [];

    for (let i = 0; i < BUFF_LIST_INITIAL_CHILDRENS * 2; i++) {
        let buffPanel = $.CreatePanel('Panel', panel, '');
        buffPanel.SetHasClass("DOTABuff", true);
        buffPanel.SetHasClass("is_debuff", !isBuffs);
        buffPanel.BLoadLayout('file://{resources}/layout/custom_game/dota_hud/dota_buff.xml', false, false);
        panel._childrens.push(buffPanel);
    }

    let buffWidth = 40;
    let buffHeight = 40;
    let buffMargins = 4;
    let bandAidFix = 5;
    panel.style.maxWidth = ((BUFF_LIST_CHILDRENS_PER_ROW * (buffWidth + buffMargins)) + bandAidFix) + "px";
    panel.style.height = (BUFF_LIST_MAX_ROWS * buffHeight) + "px";
}

(function() {
    let container = $.GetContextPanel();
    InitializeChildrens(container, container.BHasClass("customBuffs"));
})();