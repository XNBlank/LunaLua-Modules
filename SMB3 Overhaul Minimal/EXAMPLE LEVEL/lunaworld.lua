_smb3overhaul = loadAPI("smb3overhaulMIN");

function onLoad()
	_smb3overhaul.setSecondsLeft(500);
    _smb3overhaul.setTimerState(true);
    _smb3overhaul.usesPBar(true);
    _smb3overhaul.useEasyMode(true);
    _smb3overhaul.usesCard(true);
    _smb3overhaul.disableSpinJump(true);
end
