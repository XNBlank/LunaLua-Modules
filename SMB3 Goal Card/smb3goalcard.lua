local __title = "SMB3 Goal Cards";
local __version = "0.0.0.1";
local __description = "Make the SMB3 Goal Card act as it did in SMB3.";
local __author = "XNBlank";
local __url = "https://github.com/XNBlank";

local smbGoalCard_API = {} --instance

local card1 = 0; -- basically a bool. Checks if card is used
local card2 = 0;
local card3 = 0;
local card1_img = 0; --Checks the card image. 0 = Star, 1 = Mushroom, 2 = Flower
local card2_img = 0;
local card3_img = 0;
local goalcard = NPC(11);
local getframe = 0;
local gotcard = false;
local resPath = getSMBXPath() .. "\\LuaScriptsLib\\smb3goalcard"; --res path
local uicard = Graphics.loadImage(resPath .. "\\smb3card.png");
local mushroomcard = Graphics.loadImage(resPath .. "\\mushroom.png");
local flowercard = Graphics.loadImage(resPath .. "\\flower.png");
local starcard = Graphics.loadImage(resPath .. "\\star.png");

local levelFinished = false;

smbGoalCard_API.GUIPosition1 = {x = 650, y = 550}
smbGoalCard_API.GUIPosition2 = {x = 698, y = 550}
smbGoalCard_API.GUIPosition3 = {x = 746, y = 550}

function smbGoalCard_API.onInitAPI()
	gotcard = false;
	registerEvent(smbGoalCard_API, "onLoop", "onLoopOverride");
end

function smbGoalCard_API.onLoopOverride()

	temp = NPC.get(11, -1);

	if(temp == nil) then

	elseif(temp[1] ~= nil) then
	thiscard = (temp[1]:mem(0xE4, FIELD_WORD));
	Text.print(tostring(temp[1]:mem(0xE4, FIELD_WORD)), 0, 0);
	end

	--temp[0]:mem(0xE4, FIELD_WORD);


	Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition1.x,smbGoalCard_API.GUIPosition1.y, "", 2);
	Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition2.x,smbGoalCard_API.GUIPosition2.y, "", 2);
	Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition3.x,smbGoalCard_API.GUIPosition3.y, "", 2);

	if(Level.winState() > 0) then
			smbGoalCard_API.endLevel();
	end


end

function smbGoalCard_API.endLevel()

	levelFinished = true;

	if(Level.winState() > 0) then
		gotcard = true;
		if(thiscard == 1) then
			--this
			if(card1 == 0) then
				Graphics.placeSprite(1,mushroomcard,smbGoalCard_API.GUIPosition1.x,smbGoalCard_API.GUIPosition1.y, "", 2);
			elseif(card2 == 0) then
				Graphics.placeSprite(1,mushroomcard,smbGoalCard_API.GUIPosition2.x,smbGoalCard_API.GUIPosition2.y, "", 2);
			elseif(card3 == 0) then
				Graphics.placeSprite(1,mushroomcard,smbGoalCard_API.GUIPosition3.x,smbGoalCard_API.GUIPosition3.y, "", 2);
			end
		elseif(thiscard == 2) then
			--this
			if(card1 == 0) then
				Graphics.placeSprite(1,flowercard,smbGoalCard_API.GUIPosition1.x,smbGoalCard_API.GUIPosition1.y, "", 2);
			elseif(card2 == 0) then
				Graphics.placeSprite(1,flowercard,smbGoalCard_API.GUIPosition2.x,smbGoalCard_API.GUIPosition2.y, "", 2);
			elseif(card3 == 0) then
				Graphics.placeSprite(1,flowercard,smbGoalCard_API.GUIPosition3.x,smbGoalCard_API.GUIPosition3.y, "", 2);
			end
		elseif(thiscard == 0) then
			--this
			if(card1 == 0) then
				Graphics.placeSprite(1,starcard,smbGoalCard_API.GUIPosition1.x,smbGoalCard_API.GUIPosition1.y, "", 2);
			elseif(card2 == 0) then
				Graphics.placeSprite(1,starcard,smbGoalCard_API.GUIPosition2.x,smbGoalCard_API.GUIPosition2.y, "", 2);
			elseif(card3 == 0) then
				Graphics.placeSprite(1,starcard,smbGoalCard_API.GUIPosition3.x,smbGoalCard_API.GUIPosition3.y, "", 2);
			end
		end

		Text.print("Got Card!", 280, 115)
		if(thiscard == 1) then
			Graphics.placeSprite(1,mushroomcard,450,96, "", 2);
		elseif(thiscard == 2) then
			Graphics.placeSprite(1,flowercard,450,96, "", 2);
		elseif(thiscard == 0) then
			Graphics.placeSprite(1,starcard,450,96, "", 2);
		end

	end

end

return smbGoalCard_API;

